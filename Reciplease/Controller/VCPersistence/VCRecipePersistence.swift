//
//  VCRecipePersistence.swift
//  Reciplease
//
//  Created by Mehdi on 03/12/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import UIKit

/// Used to persist/delete recipes data and which is reusable in several View Controllers
struct VCRecipePersistence: VCRecipePersisting {
    
    // MARK: PROPERTIES
    var recipeManager: RecipeManager?
    var detailedRecipeManager: DetailedRecipeManager?
    
    /// Set recipe & detailed recipe manager
    ///
    /// - Parameters:
    ///   - recipeManager: recipe manager
    ///   - detailedRecipeManager: detailed recipe manager
    /// - Some parameters are optional, in case we need only one of two manger
    init(recipeManager: RecipeManager?, detailedRecipeManager: DetailedRecipeManager?) {
        self.recipeManager = recipeManager
        self.detailedRecipeManager = detailedRecipeManager
    }
    
}

// MARK: HELPER METHODS
extension VCRecipePersistence {
    
    /// Switch favorite button in detailed recipe pages, depending on recipe is saved or not in favorites
    ///
    /// - Parameters:
    ///   - favoriteButton: favorite button
    ///   - saveRecipe: method allows to save recipe in persistence
    ///   - saveDetailedRecipe: method allows to save detailed recipe in persistence
    ///   - recipeID: recipe ID
    func switchFavoriteButton(favoriteButton: UIBarButtonItem, saveRecipe: (), saveDetailedRecipe: (), recipeID: String) {
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
    
    /// Set favorite button according if the recipe already stored in the persistence or not
    
    /// Set favorite button according if the recipe already stored in the persistence or not
    ///
    /// - Parameters:
    ///   - recipeID: recipe ID
    ///   - favoriteButton: favorite button
    func setFavoriteButton(recipeID: String, favoriteButton: UIBarButtonItem) {
        guard let detailedRecipeManager = detailedRecipeManager else { return }
        if detailedRecipeManager.isRecipeExists(recipeID: recipeID) {
            favoriteButton.image = UIImage(named: UIImageNames.FavoriteSelected.rawValue)
        } else {
            favoriteButton.image = UIImage(named: UIImageNames.Favorite.rawValue)
        }
    }
    
}

// MARK: PRIVATES METHODS
extension VCRecipePersistence {
    
    private func deleteDetailedRecipe(recipeID: String) {
        guard let detailedRecipeManager = self.detailedRecipeManager else { return }
        detailedRecipeManager.removeDetailedRecipeData(recipeID: recipeID)
    }
    
    private func deleteRecipe(recipeID: String) {
        guard let recipeManager = recipeManager else { return }
        recipeManager.removeRecipeData(recipeID: recipeID)
    }
    
}
