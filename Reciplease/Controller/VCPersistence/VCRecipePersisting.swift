//
//  VCRecipePersisting.swift
//  Reciplease
//
//  Created by Mehdi on 03/12/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

/// This protocol must be implemented by structs/classes that should use recipes managers in View Controllers.
/// - Some of properties are optional type, in case we need only one of two manger
protocol VCRecipePersisting {
    var recipeManager: RecipeManager? { get set }
    var detailedRecipeManager: DetailedRecipeManager? { get set }
}
