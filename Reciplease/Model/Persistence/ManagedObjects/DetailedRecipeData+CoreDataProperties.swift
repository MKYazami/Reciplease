//
//  DetailedRecipeData+CoreDataProperties.swift
//  Reciplease
//
//  Created by Mehdi on 30/11/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//
//

import Foundation
import CoreData

extension DetailedRecipeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DetailedRecipeData> {
        return NSFetchRequest<DetailedRecipeData>(entityName: "DetailedRecipeData")
    }

    @NSManaged public var imageData: NSData?
    @NSManaged public var ingredients: NSArray?
    @NSManaged public var preparationTime: String?
    @NSManaged public var rating: Int16
    @NSManaged public var recipeID: String?
    @NSManaged public var recipeName: String?
    @NSManaged public var sourceRecipeURL: String?
    @NSManaged public var recipeData: RecipeData?

}
