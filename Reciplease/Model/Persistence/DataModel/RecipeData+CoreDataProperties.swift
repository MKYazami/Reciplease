//
//  RecipeData+CoreDataProperties.swift
//  Reciplease
//
//  Created by Mehdi on 30/11/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//
//

import Foundation
import CoreData


extension RecipeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeData> {
        return NSFetchRequest<RecipeData>(entityName: "RecipeData")
    }

    @NSManaged public var imageData: NSData?
    @NSManaged public var ingredients: NSArray?
    @NSManaged public var rating: Int16
    @NSManaged public var recipeID: String?
    @NSManaged public var recipeName: String?
    @NSManaged public var totalTimeInSeconds: Int16
    @NSManaged public var detailedRecipeData: DetailedRecipeData?

}
