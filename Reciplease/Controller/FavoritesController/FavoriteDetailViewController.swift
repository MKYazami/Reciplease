//
//  FavoriteDetailViewController.swift
//  Reciplease
//
//  Created by Mehdi on 30/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class FavoriteDetailViewController: UIViewController {
    
    // MARK: PROPERTY
    var detailedRecipe: DetailedRecipeData?
    var recipeInList: RecipeData?
    
    // MARK: OUTLET
    @IBOutlet var recipeDetailView: RecipeDetailView!
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
        configureDetailedView()
    }
    
}

// MARK: METHODS HELPER
extension FavoriteDetailViewController {
    
    private func setUpDelegates() {
        recipeDetailView.actionDelegate = self
        RecipeData.alertMessageDelegate = self
    }
    
    /// Switch BarButtonItem when user tap on it from Favorite to FavoriteSelected buttons & vice versa
    ///
    /// - Parameter favoriteButton: BarButtonItem
    private func switchFavoriteButton(favoriteButton: UIBarButtonItem) {
        if favoriteButton.image == UIImage(named: UIImageNames.FavoriteSelected.rawValue) {
            deleteDetailedRecipe()
            deleteRecipeInList()
            favoriteButton.image = UIImage(named: UIImageNames.Favorite.rawValue)
        } else if favoriteButton.image == UIImage(named: UIImageNames.Favorite.rawValue) {
            saveRecipeInList()
            saveDetailedRecipe()
            favoriteButton.image = UIImage(named: UIImageNames.FavoriteSelected.rawValue)
        }
    }
    
    /// Configure and display the custom detailed view
    private func configureDetailedView() {
        guard let detailedRecipe = detailedRecipe else { return }
        let rating: Int? = Int(detailedRecipe.rating)
        let preparationTime = detailedRecipe.preparationTime
        let recipeName = detailedRecipe.recipeName ?? "Sorry Missing Recipe Name :("
        let ingredients = (detailedRecipe.ingredients as? [String]) ?? ["Ouupps Missing Ingredients!"]
        let recipeImage = detailedRecipe.image
        recipeDetailView.detailConfiguratorFromLocalPersistence(rating: rating,
                                                                preparationTime: preparationTime,
                                                                recipeName: recipeName,
                                                                detailedRecipe: ingredients,
                                                                recipeImage: recipeImage)
    }
    
    private func getDirections(urlString: String?) {
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
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
extension FavoriteDetailViewController {
    
    /// Delete detailed recipe from persistence
    private func deleteDetailedRecipe() {
        guard let recipeID = detailedRecipe?.recipeID else { return }
        DetailedRecipeData.removeDetailedRecipeData(recipeID: recipeID)
    }
    
    /// Delete recipe in list from persistence
    private func deleteRecipeInList() {
        guard let recipeID = recipeInList?.recipeID else { return }
        RecipeData.removeRecipeData(recipeID: recipeID)
    }
    
    /// Save recipe presented in the list
    private func saveRecipeInList() {
        guard let recipeData = recipeInList else { return }
        RecipeData.saveRecipeFromLocalData(recipeData: recipeData)
    }
    
    /// Save detailed recipe
    private func saveDetailedRecipe() {
        guard let detailedRecipeData = detailedRecipe else { return }
        DetailedRecipeData.saveDetailedRecipeFromLocalData(detailedRecipe: detailedRecipeData)
    }
    
}

// MARK: ACTIONS DELEGATES
extension FavoriteDetailViewController: ListeningGetDirectionsAction {
    func listingAction() {
        getDirections(urlString: detailedRecipe?.sourceRecipeURL)
    }
}

extension FavoriteDetailViewController: ListenToAlertMessage {
    func alertMessage(alertTitle: String, message: String, actionTitle: String) {
        VCHelper.alertMessage(title: alertTitle, message: message, actionTitle: actionTitle, on: self)
    }
}
