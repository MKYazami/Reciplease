//
//  RecipeDetailView.swift
//  Reciplease
//
//  Created by Mehdi on 31/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class RecipeDetailView: UIView {
    
    // MARK: Outlets
    @IBOutlet var detailViewContent: UIView!
    
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTextView: UITextView!
    
    
    
    // MARK: Actions
    @IBAction func getDirections() {
        
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
    
    /// Load view from nib
    ///
    /// - Returns: The view from nib
    func loadFromNib() -> UIView! {
        // Get bundle
        let bundle = Bundle(for: type(of: self))
        
        // Get the nib from bundle
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        
        // Get the grid view from nib to return
        // Check gridView as UIView, because instantiate() returns [Any]
        let gridView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return gridView
    }
    
    /// Setup the nib view
    func xibSetup() {
        detailViewContent = loadFromNib()

        detailViewContent.frame = bounds

        detailViewContent.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(detailViewContent)
        
    }

}
