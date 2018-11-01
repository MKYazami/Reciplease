//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Mehdi on 30/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var cellSelectionDelegate: ListenToSelectedCell?
    
    // MARK: Outlets
    @IBOutlet weak var ratingImageView: UIImageView!
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
        if selected == true {
            cellSelectionDelegate?.listingSelection()
        }
    }
    
    /// Allows to set labels & image inside the cell
    ///
    /// - Parameters:
    ///   - rating: recipe rating
    ///   - preparationTime: time of preparation
    ///   - recipeTitle: recipe title/name
    ///   - recipeDescriptions: ingredients
    ///   - recipeURLStringImage: URL string recipe image
    ///   - imageData: image under form of data
    func cellConfigurator(rating: Int?, preparationTime: Int, recipeTitle: String, recipeDescriptions: [String], recipeURLStringImage: String?, imageData: Data?) {
        ratingImageView.image = UIImage(imageLiteralResourceName: Recipe.defineRatingStars(rating: rating))
        preparationTimeLabel.text = Recipe.convertSecondsToMinutesOrHours(numberOfSeconds: preparationTime)
        recipeTitleLabel.text = recipeTitle
        recipeDescriptionLabel.text = getStringRecipeDescriptionsFromArray(recipeDescriptions: recipeDescriptions)
        setRecipeImage(recipeURLStringImage: recipeURLStringImage, imageData: imageData)
    }
    
    /// Allows to set image depending on the source of the image, if no source is available then the default image will be displayed.
    ///
    /// - Parameters:
    ///   - recipeURLStringImage: URL which contains the image
    ///   - imageData: image under form of data
    private func setRecipeImage(recipeURLStringImage: String?, imageData: Data?) {
        if let imageData = imageData {
            recipeImageView.image = UIImage(data: imageData)
        } else if let recipeURLStringImage = recipeURLStringImage {
            recipeImageView.loadFromRemote(urlImageString: recipeURLStringImage)
        } else {
            recipeImageView.image = UIImage(imageLiteralResourceName: UIImageNames.defaultImage.rawValue)
        }
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
