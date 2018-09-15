//
//  ResultsViewController.swift
//  Reciplease
//
//  Created by Mehdi on 30/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
//    // ########################################## Data For Tests ########################################## \\
//    // MARK: Data for visual Test Preview Only !
//    // TODO: Remove For productive App
//    private let cellTitles = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"]
//
//    private let cellDescriptions = ["One Cellule", "Two Cellules", "Three Cellules", "Four Cellules", "Five Cellules", "Six Cellules", "Seven Cellules", "Eight Cellules", "Nine  Cellules"]
//    // ########################################## Data For Tests ########################################## \\
    
    // MARK: Properties
    var recipes: Recipe!
    
    // MARK: Outlets
    @IBOutlet var mainView: RecipeTableView!
    
    // MARK: Actions
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        loadCellNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mainView.tableView.reloadData()
    }
    
    private func setupDelegates() {
        mainView.tableView.dataSource = self
    }
    
    /// Load nib which contains cell
    private func loadCellNib() {
        typealias CellConstants = Constants.TableViewCells
        TableViewCellConfigurator.loadCellNib(nibName: CellConstants.recipeTableViewCellNib, cellIdentifier: CellConstants.recipeCellId, tableView: mainView.tableView)
    }

}

extension ResultsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.matches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCells.recipeCellId, for: indexPath) as? RecipeTableViewCell else {
            print("Not casted")
            return UITableViewCell()
        }

        cell.cellConfigurator(rating: recipes.matches[indexPath.row].rating, preparationTime: recipes.matches[indexPath.row].totalTimeInSeconds, recipeTitle: recipes.matches[indexPath.row].recipeName, recipeDescriptions: recipes.matches[indexPath.row].ingredients, recipeURLStringImage: recipes.matches[indexPath.row].imageUrlsBySize.imageSize90)

        return cell
    }
}
