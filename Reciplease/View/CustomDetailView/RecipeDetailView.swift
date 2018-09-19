//
//  RecipeDetailView.swift
//  Reciplease
//
//  Created by Mehdi on 31/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class RecipeDetailView: UIView {
    
    // MARK: Properties
    
    /// Allows to delegete the getDirections action to controller
    var actionDelegate: ListeningGetDirectionsAction?
    
    // MARK: Outlets
    @IBOutlet var detailViewContent: UIView!
    
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeTextView: UITextView!
    
    // MARK: Actions
    @IBAction func getDirections() {
        actionDelegate?.listingAction()
    }
    
    // MARK: Inits
    
    // Init for custom view in code
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        
    }
    
    // Init for custom view in Interface builder for the storyboard & xib files
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        
    }
    
    // MARK: Methods
    
    /// Setup the xib view
    private func xibSetup() {
        // Load nib from bundle
        Bundle.main.loadNibNamed("RecipeDetailView", owner: self, options: nil)
        // Add view loaded
        addSubview(detailViewContent)
        
        detailViewContent.frame = bounds
        detailViewContent.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // TODO: Methdo Comment!
    func detailConfigurator(rating: Int?, preparationTime: Int, recipeTitle: String, detailedRecipe: [String], recipeURLStringImage: String?) {
        ratingImageView.image = UIImage(imageLiteralResourceName: Recipe.defineRatingStars(rating: rating))
        preparationTimeLabel.text = Recipe.convertSecondsToMinutesOrHours(numberOfSeconds: preparationTime)
        recipeNameLabel.text = recipeTitle
        recipeTextView.text = getStringDetailedRecipeFromArray(detailedRecipe: detailedRecipe)
        recipeImageView.loadFromRemote(urlImageString: recipeURLStringImage)
    }
    
    /// Allows to get detailed recipe from an array to string to display it
    ///
    /// - Parameter detailedRecipe: the string array of detailed recipe
    /// - Returns: detailed recipe in form of string
    private func getStringDetailedRecipeFromArray(detailedRecipe: [String]) -> String {
        var descriptions = ""
        
        for recipeDescription in detailedRecipe {
            descriptions += "﹆ " + recipeDescription + "\n"
        }
        
        return descriptions
    }

}
