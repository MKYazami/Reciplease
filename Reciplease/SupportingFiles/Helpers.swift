//
//  Helpers.swift
//  Reciplease
//
//  Created by Mehdi on 20/09/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//
import UIKit
import Foundation

/// Contains some useful methods, generally usable to the project
struct Helper {
    
    private init() { }
    
    /// Allows to open web URL in web browser
    ///
    /// - Parameter url: URL to open
    static func openURLInWebBrowser(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    /// Allows to set range of text view in custom recipe view detail
    ///
    /// - Parameter recipeViewDetail: reciped detail view to set
    static func setTextViewScrollRangeInRecipeViewDetail(recipeViewDetail: RecipeDetailView) {
        recipeViewDetail.recipeTextView.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
    /// Switch favorite button in detailed recipe pages, depending on recipe is saved or not in favorites
    ///
    /// - Parameters:
    ///   - favoriteButton: favorite button
    ///   - saveRecipe: method allows to save recipe in persistence
    ///   - saveDetailedRecipe: method allows to save detailed recipe in persistence
    ///   - recipeID: recipe ID
    static func switchFavoriteButton(favoriteButton: UIBarButtonItem, saveRecipe: (), saveDetailedRecipe: (), recipeID: String?) {
        if favoriteButton.image == UIImage(named: UIImageNames.FavoriteSelected.rawValue) {
            deleteDetailedRecipe(recipeID: recipeID)
            deleteRecipe(recipeID: recipeID)
            favoriteButton.image = UIImage(named: UIImageNames.Favorite.rawValue)
        } else if favoriteButton.image == UIImage(named: UIImageNames.Favorite.rawValue) {
            saveRecipe
            saveDetailedRecipe
            favoriteButton.image = UIImage(named: UIImageNames.FavoriteSelected.rawValue)
        }
    }
    
}

// MARK: PRIVATE HELPER METHODS
private extension Helper {
    
    private static func deleteDetailedRecipe(recipeID: String?) {
        guard let recipeID = recipeID else { return }
        DetailedRecipeData.removeDetailedRecipeData(recipeID: recipeID)
    }
    
    private static func deleteRecipe(recipeID: String?) {
        guard let recipeID = recipeID else { return }
        RecipeData.removeRecipeData(recipeID: recipeID)
    }
}

/// Contains some useful methods, used especially in view controllers
class VCHelper: UIViewController {
    
    /// Allows to display alert message with simple action title to remove alert message
    ///
    /// - Parameters:
    ///   - title: alert title
    ///   - message: alert message
    ///   - actionTitle: action title (as: Okay, Understand…)
    ///   - viewController: the view controller that presents modally
    static func alertMessage(title: String, message: String, actionTitle: String, on viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true)
    }
    
}
