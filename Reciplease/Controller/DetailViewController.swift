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
    
    // MARK: Outlets
    @IBOutlet var recipeViewDetail: RecipeDetailView!
   
    // MARK: Actions
    @IBAction func favoriteItem(_ sender: Any) {
        
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeViewDetail.actionDelegate = self
        recipeViewDetail.detailConfigurator(rating: detailedRecipe.rating, preparationTime: detailedRecipe.totalTimeInSeconds, recipeTitle: detailedRecipe.name, detailedRecipe: detailedRecipe.ingredientLines, recipeURLStringImage: detailedRecipe.images[0].hostedLargeUrl)
    }

}

// MARK: Actions delegates
extension DetailViewController: ListeningGetDirectionsAction {
    func listingAction() {
        // TODO: Actions to get directions
    }
}
