//
//  ResultsViewController.swift
//  Reciplease
//
//  Created by Mehdi on 30/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: Properties
    var recipes: Recipe!
    var detailedRecipe: DetailedRecipe!
    
    // MARK: Outlets
    @IBOutlet var mainView: RecipeTableView!
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailedRecipe" {
            let detailVC = segue.destination as! DetailViewController
            detailVC.detailedRecipe = detailedRecipe
        }
    }
    
    private func setupDelegates() {
        mainView.tableView.dataSource = self
    }
    
    /// Load nib which contains cell
    private func loadCellNib() {
        typealias CellConstants = Constants.TableViewCells
        TableViewCellConfigurator.loadCellNib(nibName: CellConstants.recipeTableViewCellNib, cellIdentifier: CellConstants.recipeCellId, tableView: mainView.tableView)
    }

    /// Download detailed recipe elements
    ///
    /// - Parameter recipeID: recipe id that allows to get detailed recipe
    private func getDetailedRecipe(recipeID: String) {
        RecipeService(urlStringType: YummlyDetailedURLString(recipeID: recipeID)).downloadDetailedRecipe { (success, detailedRecipe) in
            if success, let detailedRecipe = detailedRecipe {
                self.detailedRecipe = detailedRecipe
                self.performSegue(withIdentifier: "segueToDetailedRecipe", sender: self)
            } else {
                self.alertMessage(title: Constants.AlertMessage.networkErrorTitle, message: Constants.AlertMessage.networkErrorDescription)
            }
        }
        
    }
    
    /// Display pop up to warn the user
    ///
    /// - Parameters:
    ///   - title: Alert title
    ///   - message: Message title
    private func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
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
        
        // Set cell delegate to self
        cell.cellSelectionDelegate = self
        return cell
    }
}

extension ResultsViewController: ListenToSelectedCell {

    /// Listing when user select action from custom table view cell
    func listingSelection() {
        // Get cell index selected by user to get detailed recipe
        guard let cellIndex = mainView.tableView.indexPathForSelectedRow?.row else { return }
        
        getDetailedRecipe(recipeID: recipes.matches[cellIndex].recipeID)
    }

}
