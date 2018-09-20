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
