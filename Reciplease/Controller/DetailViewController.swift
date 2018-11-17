//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Mehdi on 30/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: PROPERTIES
    var detailedRecipe: DetailedRecipe?
    
    // Contains the recipe items in list in order to store them in Core Data
    var recipeInList: Match?
    
    /// Global recipeID property allows to save/delete recipes by ID
    private var recipeID: String?
    
    // MARK: OUTLETS
    @IBOutlet var recipeViewDetail: RecipeDetailView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    // MARK: ACTIONS
    @IBAction func favoriteItem(_ sender: Any) {
        guard let favoriteButton = sender as? UIBarButtonItem else { return }
        switchFavoriteButton(favoriteButton: favoriteButton)
    }
    
    // MARK: METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegates()
        populateDetailedRecipeView()
        // Fill global recipeID property to fetch/delete recipes by ID
        self.recipeID = recipeInList?.recipeID
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Set text view scroll to the top
        Helper.setTextViewScrollRangeInRecipeViewDetail(recipeViewDetail: recipeViewDetail)
        // TODO: CHANGE THE FAVORITE BUTTON ACCORDING TO THE RECIPE IS SAVED OR NOT
        // - Checking in predicate and if the recipeID is already in database the favorite button must
        // be selected or deselected otherwise
    }
}

// MARK: METHODS HELPER
extension DetailViewController {
    private func setUpDelegates() {
        recipeViewDetail.actionDelegate = self
        RecipeData.alertMessageDelegate = self
    }
    
    /// Allows to populate labels, text views, image views… in detailed recipe view
    private func populateDetailedRecipeView() {
        guard let detailedRecipe = detailedRecipe else { return }
        recipeViewDetail.detailConfigurator(rating: detailedRecipe.rating,
                                            preparationTime: detailedRecipe.totalTimeInSeconds,
                                            recipeTitle: detailedRecipe.name,
                                            detailedRecipe: detailedRecipe.ingredientLines,
                                            recipeURLStringImage: detailedRecipe.images[0].hostedLargeUrl)
    }
    
    /// Switch BarButtonItem when user tap on it from Favorite to FavoriteSelected buttons & vice versa
    ///
    /// - Parameter favoriteButton: BarButtonItem
    private func switchFavoriteButton(favoriteButton: UIBarButtonItem) {
        if favoriteButton.image == UIImage(named: UIImageNames.Favorite.rawValue) {
            saveRecipeInList()
            saveDetailedRecipe()
            favoriteButton.image = UIImage(named: UIImageNames.FavoriteSelected.rawValue)
        } else if favoriteButton.image == UIImage(named: UIImageNames.FavoriteSelected.rawValue) {
            removeRecipeInList()
            removeDetailedRecipe()
            favoriteButton.image = UIImage(named: UIImageNames.Favorite.rawValue)
        }
    }
        
    private func getDirections(urlString: String) {
        guard let url = URL(string: urlString) else {
            VCHelper.alertMessage(title: Constants.AlertMessage.getDirectionsErrorTitle,
                                  message: Constants.AlertMessage.getDirectionsErrorDescription,
                                  actionTitle: Constants.AlertMessage.actionTitleOK,
                                  on: self)
            return
        }
        
        Helper.openURLInWebBrowser(url: url)
    }
    
}

// MARK: PERSISTENCE
extension DetailViewController {
    /// Save recipe presented in the list
    private func saveRecipeInList() {
        guard let recipeInList = recipeInList else { return }
        let image = recipeViewDetail.recipeImageView.image
        let imageData = image?.jpegData(compressionQuality: 0.5)
        
        RecipeData.saveRecipeFromYummlyData(recipe: recipeInList, imageData: imageData)
    }
    
    /// Save detailed recipe
    private func saveDetailedRecipe() {
        guard let detailedRecipe = detailedRecipe else { return }
        
        let image = recipeViewDetail.recipeImageView.image
        let imageData = image?.jpegData(compressionQuality: 1.0)
        let preparationTime = recipeViewDetail.preparationTimeLabel.text
        
        DetailedRecipeData.saveDetailedRecipeFromYummlyData(detailedRecipe: detailedRecipe,
                                                            recipeID: recipeID,
                                                            imageData: imageData,
                                                            preparationTime: preparationTime)
    }
    
    /// Remove recipe presented in the list
    private func removeRecipeInList() {
        guard let recipeID = recipeID else { return }
        RecipeData.removeRecipeData(recipeID: recipeID)
    }
    
    /// Remove detailed recipe
    private func removeDetailedRecipe() {
        guard let recipeID = recipeID else { return }
        DetailedRecipeData.removeDetailedRecipeData(recipeID: recipeID)
    }
}

// MARK: ACTIONS DELEGATES
extension DetailViewController: ListeningGetDirectionsAction {
    func listingAction() {
        guard let detailedRecipe = detailedRecipe else { return }
        getDirections(urlString: detailedRecipe.source.sourceRecipeUrl)
    }
}

extension DetailViewController: ListenToAlertMessage {
    func alertMessage(alertTitle: String, message: String, actionTitle: String) {
        VCHelper.alertMessage(title: alertTitle, message: message, actionTitle: actionTitle, on: self)
    }
}
