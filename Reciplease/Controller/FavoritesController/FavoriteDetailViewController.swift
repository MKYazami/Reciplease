//
//  FavoriteDetailViewController.swift
//  Reciplease
//
//  Created by Mehdi on 30/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class FavoriteDetailViewController: UIViewController {
    
    // MARK: Property
    var detailedRecipe: DetailedRecipeData?
    var recipeInList: RecipeData?
    
    // MARK: Outlet
    @IBOutlet var recipeDetailView: RecipeDetailView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    // MARK: Actions
    @IBAction func favoriteItem(_ sender: Any) {
        guard let favoriteButton = sender as? UIBarButtonItem else { return }
        switchFavoriteButton(favoriteButton: favoriteButton)
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailView.actionDelegate = self
        configureDetailedView()
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
    
    /// Save detailed recipe
    private func saveDetailedRecipe() {
        guard let detailedRecipeData = detailedRecipe else { return }
        DetailedRecipeData.saveDetailedRecipeFromLocalData(detailedRecipe: detailedRecipeData)
    }
    
    /// Save recipe presented in the list
    private func saveRecipeInList() {
        guard let recipeData = recipeInList else { return }
        RecipeData.saveRecipeFromLocalData(recipeData: recipeData)
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
            alertMessage(title: Constants.AlertMessage.getDirectionsErrorTitle,
                         message: Constants.AlertMessage.getDirectionsErrorDescription)
            return
        }
        
        Helper.openURLInWebBrowser(url: url)
    }
    
    /// Display pop up to warn the user
    ///
    /// - Parameters:
    ///   - title: Alert title
    ///   - message: Message title
    private func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

extension FavoriteDetailViewController: ListeningGetDirectionsAction {
    func listingAction() {
        getDirections(urlString: detailedRecipe?.sourceRecipeURL)
    }
}
