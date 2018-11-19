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
        Helper.switchFavoriteButton(favoriteButton: favoriteButton,
                                    saveRecipe: saveRecipeInList(),
                                    saveDetailedRecipe: saveDetailedRecipe(),
                                    recipeID: detailedRecipe?.recipeID)
    }
    
    // MARK: METHODS OVERRIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegates()
        configureDetailedView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Helper.setTextViewScrollRangeInRecipeViewDetail(recipeViewDetail: recipeDetailView)
        Helper.setFavoriteButton(recipeID: detailedRecipe?.recipeID, favoriteButton: favoriteButton)
    }
    
}

// MARK: METHODS HELPER
extension FavoriteDetailViewController {
    
    private func setUpDelegates() {
        recipeDetailView.actionDelegate = self
        RecipeData.alertMessageDelegate = self
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
