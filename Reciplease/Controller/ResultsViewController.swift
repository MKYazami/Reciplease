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
    /// Get Table View data source
    private let tableViewDataSource = RecipeTableViewDataSource()
    
    // MARK: Outlets
    @IBOutlet var mainView: RecipeTableView!
    
    // MARK: Actions
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        
        //Load nib which contains cell
        typealias CellConstants = Constants.TableViewCells
        TableViewConfigurator.loadCellNib(nibName: CellConstants.recipeTableViewCellNib, cellIdentifier: CellConstants.recipeCellId, tableView: mainView.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        mainView.tableView.reloadData()
    }
    
    private func setupDelegates() {
        mainView.tableView.dataSource = tableViewDataSource
    }

}
