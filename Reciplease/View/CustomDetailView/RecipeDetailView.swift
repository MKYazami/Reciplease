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
    
    /// Allows to delegete the getDirections action to controllers
    var actionDelegate: ListeningActionsProtocol?
    
    // MARK: Outlets
    @IBOutlet var detailViewContent: UIView!
    
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
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
    
    /// Setup the xib view
    private func xibSetup() {
        // Load nib from bundle
        Bundle.main.loadNibNamed("RecipeDetailView", owner: self, options: nil)
        // Add view loaded
        addSubview(detailViewContent)
        
        detailViewContent.frame = bounds
        detailViewContent.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
