//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Mehdi on 30/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Properties
    var detailedRecipe: DetailedRecipe!
    
    // Global recipeID property allows to save the detailed recipe ID
    private var recipeID: String?
    
    // Contains the recipe items in list in order to store them in Core Data
    var recipeInList: Match?
    
    // Init contexts
    private let detailedRecipeData = DetailedRecipeData(context: AppDelegate.viewContext)
    private let listRecipeData = RecipeData(context: AppDelegate.viewContext)
    
    // MARK: Outlets
    @IBOutlet var recipeViewDetail: RecipeDetailView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    // MARK: Actions
    @IBAction func favoriteItem(_ sender: Any) {
        guard let favoriteButton = sender as? UIBarButtonItem else { return }
        switchFavoriteButton(favoriteButton: favoriteButton)
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeViewDetail.actionDelegate = self
        recipeViewDetail.detailConfigurator(rating: detailedRecipe.rating, preparationTime: detailedRecipe.totalTimeInSeconds, recipeTitle: detailedRecipe.name, detailedRecipe: detailedRecipe.ingredientLines, recipeURLStringImage: detailedRecipe.images[0].hostedLargeUrl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Set text view scroll to the top
        recipeViewDetail.recipeTextView.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
    private func getDirections(urlString: String) {
        guard let url = URL(string: urlString) else {
            alertMessage(title: "Impossible to get directions!", message: "Try later or with another recipe.")
            return
        }
        
        Helper.openURLInWebBrowser(url: url)
    }
    
    /// Switch BarButtonItem when user tap on it from Favorite to FavoriteSelected buttons & vice versa
    ///
    /// - Parameter favoriteButton: BarButtonItem
    private func switchFavoriteButton(favoriteButton: UIBarButtonItem) {
        if favoriteButton.image == UIImage(named: "Favorite") {
            saveRecipeInList()
            saveDetailedRecipe()
            favoriteButton.image = UIImage(named: "FavoriteSelected")
        } else if favoriteButton.image == UIImage(named: "FavoriteSelected") {
            removeRecipeInList()
            removeDetailedRecipe()
            favoriteButton.image = UIImage(named: "Favorite")
        }
    }
    
    /// Save recipe presented in the list
    private func saveRecipeInList() {
        guard let recipeInList = recipeInList else { return }
        let recipeName = recipeInList.recipeName
        let recipeID = recipeInList.recipeID
        let rating = recipeInList.rating ?? 0
        let image = recipeViewDetail.recipeImageView.image
        let ingredients = recipeInList.ingredients
        let totalTimeInSeconds = recipeInList.totalTimeInSeconds
        
        // Fill global recipeID property
        self.recipeID = recipeID
        
        // Save data
        listRecipeData.recipeName = recipeName
        listRecipeData.recipeID = recipeID
        listRecipeData.rating = Int16(rating)
        listRecipeData.image = image?.jpegData(compressionQuality: 1.0)
        listRecipeData.ingredients = ingredients as NSArray
        listRecipeData.totalTimeInSeconds = Int16(totalTimeInSeconds)
        listRecipeData.detailedRecipe = detailedRecipeData
        
        do {
            try AppDelegate.viewContext.save()
        } catch let error as NSError {
            alertMessage(title: Constants.AlertMessage.saveRecipeErrorTitle, message: Constants.AlertMessage.saveRecipeErrorDescription)
            print("Recipe in list saving error: \n \(error) \n User Info Error —> \(error.userInfo)")
        }
    }
    
    /// Remove recipe presented in the list
    private func removeRecipeInList() {
        AppDelegate.viewContext.delete(listRecipeData)
        do {
            try AppDelegate.viewContext.save()
            
        } catch let error as NSError {
            alertMessage(title: Constants.AlertMessage.deleteRecipeErrorTitle, message: Constants.AlertMessage.deleteRecipeErrorDescription)
            print("Deleting error: \n \(error) \n User Info Error —> \(error.userInfo)")
        }
    }
    
    /// Save detailed recipe
    private func saveDetailedRecipe() {
        // Get detail recipe items
        let recipeName = detailedRecipe.name
        let rating = detailedRecipe.rating
        let preparationTime = recipeViewDetail.preparationTimeLabel.text
        let recipeImage = recipeViewDetail.recipeImageView.image
        let ingredients = detailedRecipe.ingredientLines
        let sourceRecipeURL = detailedRecipe.source.sourceRecipeUrl
        
        // Save data
        detailedRecipeData.recipeName = recipeName
        detailedRecipeData.recipeID = recipeID
        detailedRecipeData.rating = Int16(rating)
        detailedRecipeData.preparationTime = preparationTime
        detailedRecipeData.image = recipeImage?.jpegData(compressionQuality: 1.0)
        detailedRecipeData.ingredients = ingredients as NSArray
        detailedRecipeData.sourceRecipeURL = sourceRecipeURL
        
        do {
            try AppDelegate.viewContext.save()
        } catch let error as NSError {
            alertMessage(title: Constants.AlertMessage.saveRecipeErrorTitle, message: Constants.AlertMessage.saveRecipeErrorDescription)
            print("Detailed recipe saving error: \n \(error) \n User Info Error —> \(error.userInfo)")
        }
    }
    
    /// Remove detailed recipe
    private func removeDetailedRecipe() {
        AppDelegate.viewContext.delete(detailedRecipeData)
        do {
            try AppDelegate.viewContext.save()
        } catch let error as NSError {
            alertMessage(title: Constants.AlertMessage.deleteRecipeErrorTitle, message: Constants.AlertMessage.deleteRecipeErrorDescription)
            print("Deleting error: \n \(error) \n User Info Error —> \(error.userInfo)")
        }
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

// MARK: Actions delegates
extension DetailViewController: ListeningGetDirectionsAction {
    func listingAction() {
        getDirections(urlString: detailedRecipe.source.sourceRecipeUrl)
    }
}
