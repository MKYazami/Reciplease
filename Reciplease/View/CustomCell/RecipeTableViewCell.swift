//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Mehdi on 30/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var preparationTimeLabel: UILabel!
    
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeDescriptionLabel: UILabel!
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    // MARK: Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Allows to set labels & image inside the cell
    ///
    /// - Parameters:
    ///   - preparationTime: Time of preparation
    ///   - recipeTitle: Recipe title
    ///   - recipeDescriptions: Recipe description
    ///   - recipeURLStringImage: URL string recipe image
    func cellConfigurator(preparationTime: Int, recipeTitle: String, recipeDescriptions: [String], recipeURLStringImage: String?) {
        preparationTimeLabel.text = Recipe.convertSecondsToMinutesOrHours(numberOfSeconds: preparationTime)
        recipeTitleLabel.text = recipeTitle
        recipeDescriptionLabel.text = getStringRecipeDescriptionsFromArray(recipeDescriptions: recipeDescriptions)
        recipeImageView.loadFromRemote(urlImageString: recipeURLStringImage)
    }
    
    /// Allows to get recipe desciptions from an array to string to display it
    ///
    /// - Parameter recipeDescriptions: the string array of recipe descriptions
    /// - Returns: recipe descriptions in form of string
    private func getStringRecipeDescriptionsFromArray(recipeDescriptions: [String]) -> String {
        var descriptions = ""
        
        for recipeDescription in recipeDescriptions {
            if recipeDescription == recipeDescriptions.last {
                descriptions += recipeDescription
            } else {
                descriptions += recipeDescription + ", "
            }
        }
        
        return descriptions
    }
    
}
