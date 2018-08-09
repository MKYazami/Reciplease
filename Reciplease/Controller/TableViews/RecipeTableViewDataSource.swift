//
//  TableViewDataSource.swift
//  Reciplease
//
//  Created by Mehdi on 05/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation
import UIKit

/// Allows to set the Table View Data Source in order to be shared with same table view type
class RecipeTableViewDataSource: NSObject, UITableViewDataSource {
    
    // ########################################## Data For Tests ########################################## \\
    // MARK: Data for visual Test Preview Only !
    // TODO: Remove For productive App
    private let cellTitles = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"]
    
    private let cellDescriptions = ["One Cellule", "Two Cellules", "Three Cellules", "Four Cellules", "Five Cellules", "Six Cellules", "Seven Cellules", "Eight Cellules", "Nine  Cellules"]
    // ########################################## Data For Tests ########################################## \\

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCells.recipeCellId, for: indexPath) as? RecipeTableViewCell else {
            print("Not casted")
            return UITableViewCell()
        }
        
        cell.cellConfigurator(preparationTime: "10", recipeTitle: cellTitles[indexPath.row], recipeDescription: cellDescriptions[indexPath.row], recipeImage: UIImage(imageLiteralResourceName: "AppIcon"))
        
        return cell
    }

}

protocol CustomCellType {
    var customCell: UITableViewCell { get }
}
