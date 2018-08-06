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
    ///   - recipeDescription: Recipe description
    ///   - recipeImage: Recipe image
    func cellConfigurator(preparationTime: String, recipeTitle: String, recipeDescription: String, recipeImage: UIImage) {
        preparationTimeLabel.text = preparationTime
        recipeTitleLabel.text = recipeTitle
        recipeDescriptionLabel.text = recipeDescription
        recipeImageView.image = recipeImage
    }
}
