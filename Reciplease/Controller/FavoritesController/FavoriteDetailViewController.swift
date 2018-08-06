//
//  FavoriteDetailViewController.swift
//  Reciplease
//
//  Created by Mehdi on 30/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class FavoriteDetailViewController: UIViewController {
    
    // MARK: Properties
    @IBOutlet var recipeDetailView: RecipeDetailView!
    
    // MARK: Outlets
    
    // MARK: Actions
    @IBAction func favoriteItem(_ sender: Any) {
        
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailView.actionDelegate = self
    }
}

extension FavoriteDetailViewController: ListeningActionsProtocol {
    func listingAction() {
        // TODO: Actions to get directions
    }
}
