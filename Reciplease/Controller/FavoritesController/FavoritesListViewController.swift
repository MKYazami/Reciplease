//
//  FavoritesListViewController.swift
//  Reciplease
//
//  Created by Mehdi on 30/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class FavoritesListViewController: UIViewController {
    
    // MARK: PROPERTIES
    private var recipes: [RecipeData]?
    // Property to transfert to FavoriteDetailViewController for Persistence manipulations
    var recipeInList: RecipeData?
    var detailedRecipe: DetailedRecipeData?
    
    // MARK: OUTLETS
    @IBOutlet var mainView: RecipeTableView!
    
    // MARK: METHODS OVERRIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        loadCellNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUserInformationTextField()
        recipes = RecipeData.getRecipes
        mainView.tableView.reloadData()
        toogleActivityIndicator(shown: false)
        toogleTableViewUserInteractions(enable: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.Segue.toFavoriteDetail {
            let favoriteDetailedVC = segue.destination as! FavoriteDetailViewController
            favoriteDetailedVC.detailedRecipe = detailedRecipe
            favoriteDetailedVC.recipeInList = recipeInList
        }
        
    }
    
}

// MARK: METHODS HELPER
extension FavoritesListViewController {
    
    private func setupDelegates() {
        mainView.tableView.dataSource = self
    }
    
    /// Load nib which contains cell
    private func loadCellNib() {
        typealias CellConstants = Constants.TableViewCells
        TableViewCellConfigurator.loadCellNib(nibName: CellConstants.recipeTableViewCellNib,
                                              cellIdentifier: CellConstants.recipeCellId,
                                              tableView: mainView.tableView)
    }
    
    /// Allows to show or hide the user information text field according if there is almost one recipe or more in the favorite
    private func setUserInformationTextField() {
        if RecipeData.isFavoriteRecipeEmpty {
            mainView.userInformationTextField.isHidden = false
        } else {
            mainView.userInformationTextField.isHidden = true
        }
    }
    
    /// Allows to enable OR desable the interactions between the user & the table view selection
    ///
    /// - Parameter enable: true interaction is enable & false interaction is disable
    private func toogleTableViewUserInteractions(enable: Bool) {
        mainView.tableView.isUserInteractionEnabled = enable
    }
    
    /// Allows to show or hide the acitity indicator
    ///
    /// - Parameter shown: true to show & false to hide
    private func toogleActivityIndicator(shown: Bool) {
        mainView.activityIndicator.isHidden = !shown
    }
    
}

// MARK: PERSISTENCE
extension FavoritesListViewController {
    
    private func getDetailedRecipeData(recipeID: String) {
        let fetchRequest = DetailedRecipeData.getDetailedRecipesFetchRequest(recipeID: recipeID)
        
        do {
            let detailedRecipeData = try AppDelegate.viewContext.fetch(fetchRequest)
            
            detailedRecipe = detailedRecipeData.first
            
            performSegue(withIdentifier: Constants.Segue.toFavoriteDetail, sender: self)
        } catch let error as NSError {
            print("Error to get detailed recipe from Core Data \(error) \n Error Description: \(error.userInfo)")
            Helper.alertMessage(title: Constants.AlertMessage.getDetailedRecipeErrorTitle,
                                  message: Constants.AlertMessage.getDetailedRecipeErrorDescription,
                                  actionTitle: Constants.AlertMessage.actionTitleOK,
                                  on: self)
            toogleActivityIndicator(shown: false)
            toogleTableViewUserInteractions(enable: true)
        }
    }
    
}

// MARK: TABLE VIEW
extension FavoritesListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipes = recipes else { return 0 }
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // This empty cell allows to return cell with background color as light orange color totally transparent (same as table view background color) in order to avoid bad design color
        let emptyCell = UITableViewCell()
        emptyCell.backgroundColor = UIColor(red: 228/255, green: 126/255, blue: 72/255, alpha: 0)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCells.recipeCellId, for: indexPath) as? RecipeTableViewCell else { return emptyCell }
        
        // Set cell delegate
        cell.cellSelectionDelegate = self
        
        // Get elements from recipes to send to custom cell
        guard let recipes = recipes else { return emptyCell }
        let rating = Int(recipes[indexPath.row].rating)
        let preparationTime = Int(recipes[indexPath.row].totalTimeInSeconds)
        guard let recipeName = recipes[indexPath.row].recipeName else { return emptyCell }
        guard let recipeDescription = recipes[indexPath.row].ingredients as? [String] else { return emptyCell }
        let imageData = recipes[indexPath.row].image
        
        cell.cellConfigurator(rating: rating, preparationTime: preparationTime, recipeTitle: recipeName, recipeDescriptions: recipeDescription, recipeURLStringImage: nil, imageData: imageData)
        
        return cell
    }
}

// MARK: LISTEN TO SELECTED CELL
extension FavoritesListViewController: ListenToSelectedCell {
    
    /// Listing when user select action from custom table view cell
    func listingSelection() {
        
        toogleTableViewUserInteractions(enable: false)
        toogleActivityIndicator(shown: true)
        
        // Get cell index selected by user to get detailed recipe
        guard let cellIndex = mainView.tableView.indexPathForSelectedRow?.row else { return }
        
        // Get recipeInList selected by user
        recipeInList = recipes?[cellIndex]
        
        // Get recipe ID
        guard let recipe = recipes?[cellIndex],
        let recipeID = recipe.recipeID else { return }

        getDetailedRecipeData(recipeID: recipeID)
    }
    
}
