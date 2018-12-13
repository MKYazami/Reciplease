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
    var coreDataStack: CoreDataStack!
    private lazy var recipeManager = RecipeManager(coreDataStack: coreDataStack,
                                                   managedContext: coreDataStack.mainContext)
    private lazy var detailedRecipeManager = DetailedRecipeManager(coreDataStack: coreDataStack,
                                                                   managedContext: coreDataStack.mainContext)
    private lazy var vcRecipePersistence = VCRecipePersistence(recipeManager: recipeManager,
                                                               detailedRecipeManager: detailedRecipeManager)
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = .white
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        return searchController
    }()
    
    /// Recipes that coming from filtered recipes by user
    private var filteredRecipes = [RecipeData]()
    
    private var recipes: [RecipeData]?
    
    /// Property to transfert to FavoriteDetailViewController for Persistence manipulations
    private var recipeInList: RecipeData?
    private var detailedRecipe: DetailedRecipeData?
    
    // MARK: OUTLETS
    @IBOutlet var mainView: RecipeTableView!
    
    // MARK: METHODS OVERRIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        loadCellNib()
        assignSearchControllerToNavItemSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        recipes = recipeManager.getRecipes
        mainView.tableView.reloadData()
        toogleActivityIndicator(shown: false)
        toogleTableViewUserInteractions(enable: true)
        setSearchBarPlaceHolder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.Segue.toFavoriteDetail {
            let favoriteDetailedVC = segue.destination as! FavoriteDetailViewController
            favoriteDetailedVC.detailedRecipe = detailedRecipe
            favoriteDetailedVC.recipeInList = recipeInList
            favoriteDetailedVC.coreDataStack = coreDataStack
        }
        
    }
    
}

// MARK: METHODS HELPER
extension FavoritesListViewController {
    
    private func setupDelegates() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        recipeManager.alertMessageDelegate = self
        detailedRecipeManager.alertMessageDelegate = self
    }
    
    /// Load nib which contains cell
    private func loadCellNib() {
        typealias CellConstants = Constants.TableViewCells
        TableViewCellConfigurator.loadCellNib(nibName: CellConstants.recipeTableViewCellNib,
                                              cellIdentifier: CellConstants.recipeCellId,
                                              tableView: mainView.tableView)
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
        let fetchRequest = detailedRecipeManager.getDetailedRecipesFetchRequest(recipeID: recipeID)
        
        do {
            let detailedRecipeData = try coreDataStack.mainContext.fetch(fetchRequest)
            
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

// MARK: TABLE VIEW DATA SOURCE
extension FavoritesListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipes = recipes else { return 0 }
        
        if isSearchBarFiltering { return filteredRecipes.count }
        
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // This empty cell allows to return cell with background color as light orange color totally transparent (same as table view background color) in order to avoid bad design color
        let emptyCell = UITableViewCell()
        emptyCell.backgroundColor = UIColor(red: 228/255, green: 126/255, blue: 72/255, alpha: 0)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewCells.recipeCellId,
                                                       for: indexPath) as? RecipeTableViewCell else { return emptyCell }
        
        // Set cell delegate
        cell.cellSelectionDelegate = self
        
        guard let recipes = recipes else { return emptyCell }
        var recipe: RecipeData
        
        if isSearchBarFiltering {
            recipe = filteredRecipes[indexPath.row]
        } else {
            recipe = recipes[indexPath.row]
        }
        
        // Get elements from recipes to send to custom cell
        let rating = Int(recipe.rating)
        let preparationTime = Int(recipe.totalTimeInSeconds)
        guard let recipeName = recipe.recipeName else { return emptyCell }
        guard let recipeDescription = recipe.ingredients as? [String] else { return emptyCell }
        let imageData = recipe.imageData as Data?
        
        cell.cellConfigurator(rating: rating, preparationTime: preparationTime,
                              recipeTitle: recipeName, recipeDescriptions: recipeDescription,
                              recipeURLStringImage: nil, imageData: imageData)
        
        return cell
    }
}

// MARK: TABLE VIEW DELEGATE
extension FavoritesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let textView = UITextView()
        
        textView.isEditable = false
        textView.isSelectable = false
        
        textView.backgroundColor = UIColor(red: 243/255, green: 120/255,
                                           blue: 56/255, alpha: 0)

        textView.text = """
        No recipes in the favorites!

        To add new recipes to favorites:
        1.  Enter the ingredients in the search tab
        2. Choose a recipe
        3. Touch the star at the top right of the screen
        """
        
        textView.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        textView.textColor = .white
        
        return textView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard recipeManager.isFavoriteRecipeEmpty else { return 0 }
        
        return 220
    }
    
}

// MARK: - UISEARCHRESULTS UPDATING — SEARCH BAR
extension FavoritesListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterRecipesFromSearchBar(searchBarText: searchController.searchBar.text)
    }
    
    /// Allows to assign the searchController to the searchController in the navigation item
    private func assignSearchControllerToNavItemSearchController() {
        navigationItem.searchController = searchController
    }
    
    /// Filter recipes names from search bar text to filteredRecipes to know what is tapping from user
    ///
    /// - Parameter searchBarText: text tapped from search bar
    private func filterRecipesFromSearchBar(searchBarText: String?) {
        
        guard let recipes = recipes else { return }
        filteredRecipes = recipes.filter({ (recipe) -> Bool in
            guard let recipeName = recipe.recipeName else { return false }
            guard let searchBarText = searchBarText else { return false }
            return recipeName.lowercased().contains(searchBarText.lowercased())
        })
        
        mainView.tableView.reloadData()
        
    }
    
    private var isSearchBarFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    /// Check if search bar is empty
    /// - return true if text is empty or is nil
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private func setSearchBarPlaceHolder() {
        searchController.searchBar.placeholder = recipeManager.isFavoriteRecipeEmpty ?
            "No recipe to search!" : "Search Recipe"
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
        
        guard let recipes = recipes else { return }
        
        // This variable allows to get the correct recipeID
        // If is from standard table view results OR filtering table view results
        var recipeFromList: RecipeData
        
        // Get recipe selected by user
        if isSearchBarFiltering {
            recipeInList = filteredRecipes[cellIndex]
            recipeFromList = filteredRecipes[cellIndex]
        } else {
            recipeInList = recipes[cellIndex]
            recipeFromList = recipes[cellIndex]
        }
        
        // Get recipe ID
        guard let recipeID = recipeFromList.recipeID else { return }

        getDetailedRecipeData(recipeID: recipeID)
    }
    
}

extension FavoritesListViewController: ListenToAlertMessage {
    
    func alertMessage(alertTitle: String, message: String, actionTitle: String) {
        Helper.alertMessage(title: alertTitle, message: message, actionTitle: actionTitle, on: self)
    }
    
}
