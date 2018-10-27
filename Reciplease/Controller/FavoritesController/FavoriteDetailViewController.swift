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
    
    // MARK: Outlet
    @IBOutlet var recipeDetailView: RecipeDetailView!
    
    // MARK: Actions
    @IBAction func favoriteItem(_ sender: Any) {
        
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailView.actionDelegate = self
        configureDetailedView()
    }
    
    /// Configure and display the custom detailed view
    private func configureDetailedView() {
        guard let detailedRecipe = detailedRecipe else { return }
        let rating: Int? = Int(detailedRecipe.rating)
        let preparationTime = detailedRecipe.preparationTime
        let recipeName = detailedRecipe.recipeName ?? "Sorry Missing Recipe Name :("
        let ingredients = (detailedRecipe.ingredients as? [String]) ?? ["Ouupps Missing Ingredients!"]
        let recipeImage = detailedRecipe.image
        recipeDetailView.detailConfiguratorFromLocalPersistence(rating: rating, preparationTime: preparationTime, recipeName: recipeName, detailedRecipe: ingredients, recipeImage: recipeImage)
    }
}

extension FavoriteDetailViewController: ListeningGetDirectionsAction {
    func listingAction() {
        // TODO: Actions to get directions
    }
}
