//
//  RecipeTableView.swift
//  Reciplease
//
//  Created by Mehdi on 05/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class RecipeTableView: UIView {
    
    // MARK: Outlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var userInformationTextField: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
        Bundle.main.loadNibNamed("RecipeTableView", owner: self, options: nil)
        // Add view loaded
        addSubview(contentView)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
