//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Mehdi on 30/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    // MARK: Properties
    var detailedRecipe: DetailedRecipe?
    
    // Contains the recipe items in list in order to store them in Core Data
    var recipeInList: Match?
    
    /// Global recipeID property allows to save/delete recipes by ID
    private var recipeID: String?
    
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
        setUpDelegates()
        populateDetailedRecipeView()
        // Fill global recipeID property to fetch/delete recipes by ID
        self.recipeID = recipeInList?.recipeID
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Set text view scroll to the top
        recipeViewDetail.recipeTextView.scrollRangeToVisible(NSRange(location: 0, length: 0))
        // TODO: CHANGE THE FAVORITE BUTTON ACCORDING TO THE RECIPE IS SAVED OR NOT
        // - Checking in predicate and if the recipeID is already in database the favorite button must
        // be selected or deselected otherwise
    }
}

// MARK: Methods Helper
extension DetailViewController {
    private func setUpDelegates() {
        recipeViewDetail.actionDelegate = self
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

// MARK: Persistence
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
        
        // Get detail recipe items
        let recipeName = detailedRecipe.name
        let rating = detailedRecipe.rating
        let preparationTime = recipeViewDetail.preparationTimeLabel.text
        let recipeImage = recipeViewDetail.recipeImageView.image
        let ingredients = detailedRecipe.ingredientLines
        let sourceRecipeURL = detailedRecipe.source.sourceRecipeUrl
        
        // Save data
        let detailedRecipeData = DetailedRecipeData(context: AppDelegate.viewContext)
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
            alertMessage(title: Constants.AlertMessage.saveRecipeErrorTitle,
                         message: Constants.AlertMessage.saveRecipeErrorDescription)
            print("Detailed recipe saving error: \n \(error) \n User Info Error —> \(error.userInfo)")
        }
    }
    
    /// Remove recipe presented in the list
    private func removeRecipeInList() {
        guard let recipeID = recipeID else { return }
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "RecipeData")
        fetch.predicate = NSPredicate(format: "%K == %@", #keyPath(RecipeData.recipeID), recipeID)
        
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try AppDelegate.viewContext.execute(request)
        } catch let error as NSError {
            print("Error to delete detailed recipe \(error) \n Description: \(error.userInfo)")
        }
    }
    
    /// Remove detailed recipe
    private func removeDetailedRecipe() {
        guard let recipeID = recipeID else { return }
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DetailedRecipeData")
        fetch.predicate = NSPredicate(format: "%K == %@", #keyPath(DetailedRecipeData.recipeID), recipeID)
        
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try AppDelegate.viewContext.execute(request)
        } catch let error as NSError {
            print("Error to delete detailed recipe \(error) \n Description: \(error.userInfo)")
        }
    }
}

// MARK: Actions delegates
extension DetailViewController: ListeningGetDirectionsAction {
    func listingAction() {
        guard let detailedRecipe = detailedRecipe else { return }
        getDirections(urlString: detailedRecipe.source.sourceRecipeUrl)
    }
}
