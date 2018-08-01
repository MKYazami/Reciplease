//
//  DetailViewController.swift
//  Reciplease
//
//  Created by Mehdi on 30/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet var recipeViewDetail: RecipeDetailView!
   
    // MARK: Actions
    @IBAction func favoriteItem(_ sender: Any) {
        
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeViewDetail.actionDelegate = self
    }

}

// MARK: Actions delegates
extension DetailViewController: ListeningActionsProtocol {
    func listingAction() {
        // TODO: Actions to get directions
    }
}
