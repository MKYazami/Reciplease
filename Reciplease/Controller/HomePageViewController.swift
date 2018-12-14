//
//  HomePageViewController.swift
//  Reciplease
//
//  Created by Mehdi on 29/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    
    // MARK: PROPERTIES
    private var recipes: Recipe!
    var coreDataStack: CoreDataStack!
    
    /// String set to remove duplicated ingredients in text view.
    /// All ingredients are strored in this set untill the user decides to clear all ingredients.
    private var ingredientsSetInTextView = Set<String>()
    
    // MARK: OUTLETS
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBoutton: UIButton!
    
    // MARK: ACTIONS
    @IBAction func addIngredients() {
        getIngredientsFromTextField(ingredients: ingredientsTextField.text)
        resetIngredientsTextField()
    }
    
    @IBAction func clearIngredients() {
        if !ingredientsTextView.text.isEmpty {
            clearIngredientsConfirmation()
        }
    }
        
    @IBAction func searchRecipes() {
        if !ingredientsSetInTextView.isEmpty {
            self.toogleActivityIndicator(shown: true)
            getRecipes()
        } else {
            Helper.alertMessage(title: "No ingredients!",
                                  message: "Thank you to enter at least one ingredient to get recipe",
                                  actionTitle: Constants.AlertMessage.actionTitleOK, on: self)
        }
    }
    
    // MARK: METHODS OVERRIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        resetTexts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.toogleActivityIndicator(shown: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.toRecipesResults {
            let resultesVC = segue.destination as! ResultsViewController
            resultesVC.recipes = recipes
            resultesVC.coreDataStack = coreDataStack
        }
    }
    
}

// MARK: NETWORK REQUEST
extension HomePageViewController {
    
    private func getRecipes() {
        guard let ingredients = ingredientsTextView.text else { return }
        let ingredientsInArray = ingredients.convertStringToStringArray(separator: ["\n"])
        
        guard ingredientsInArray.count > 0 else { return }
        
        RecipeService(urlStringType: YummlySession(ingredients: ingredientsInArray)).downloadRecipe { (success, recipe) in
            if success, let recipe = recipe {
                self.recipes = recipe
                self.performSegue(withIdentifier: Constants.Segue.toRecipesResults, sender: self)
            } else {
                Helper.alertMessage(title: Constants.AlertMessage.networkErrorTitle,
                                      message: Constants.AlertMessage.networkErrorDescription,
                                      actionTitle: Constants.AlertMessage.actionTitleOK,
                                      on: self)
                self.toogleActivityIndicator(shown: false)
            }
        }
    }
    
}

// MARK: METHODS HELPER
extension HomePageViewController {
    
    private func setupDelegates() {
        ingredientsTextField.delegate = self
    }
    
    /// Get ingredient from user entred in text field
    ///
    /// - Parameter ingredients: String contained in the text field
    private func getIngredientsFromTextField(ingredients: String?) {
        
        guard let ingredients = ingredients else { return }
        
        if !ingredients.isEmpty {
            // Remove spaces at the beginning and end of the string to avoid bugs when adding ingredients in the text view
            let trimmedIngredients = ingredients.trimmingCharacters(in: .whitespaces)
            
            // Transforming the ingredients in string separated by space to ingredients in array
            let ingredientsInArray = trimmedIngredients.convertStringToStringArray(separator: [" "])
            
            addIngredientsToTextView(ingredients: ingredientsInArray)
        }
    }
    
    /// Add ingredients to the text view
    ///
    /// - Parameter ingredients: The ingredients stored in string array
    private func addIngredientsToTextView(ingredients: [String]) {
        
        // ingredientsTextView.text + "" => To avoid losing previously entered ingredients after erasing the text field
        var ingredientToList = ""
        
        // Removing duplicated ingredient entred by user in text field => ex : orange lemon ❌orange❌
        let nonDuplicatedIngredientsFromTextField = [Any].removeDuplicatedStringArrayItem(stringArray: ingredients)
        
        // Insert ingredients from Array which contains ingredients from text field to the Set<String> which contains ingredients in text view to remove duplicated ingredient
        for ingredient in nonDuplicatedIngredientsFromTextField {
            if ingredient.count > 2 && !ingredient.isEmpty {
                // Set<String> which contains all ingredients in text view
                ingredientsSetInTextView.insert(ingredient)
            }
        }
        
        // Fill ingredients from Set<String> to string with new line to present them as list
        for ingredient in ingredientsSetInTextView {
            ingredientToList += "﹆ \(ingredient)\n"
        }
        
        ingredientsTextView.text = ingredientToList
        
        // Dismiss keyboard after add ingredient(s)
        if !ingredientToList.isEmpty {
            view.endEditing(true)
        }
    }
    
    /// Present confirmation message to delete the ingredients from text view with the possibility to cancel the deletation
    private func clearIngredientsConfirmation() {
        let alertMessage = UIAlertController(title: "Delete all ingredients?",
                                             message: "If you erase the ingredients you will not be able to recover them!",
                                             preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default) { (_) in
            self.view.endEditing(true)
            self.resetIndredientsTextView()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            return
        }
        
        alertMessage.addAction(deleteAction)
        alertMessage.addAction(cancelAction)
        
        present(alertMessage, animated: true, completion: nil)
    }
    
    private func toogleActivityIndicator(shown: Bool) {
        searchActivityIndicator.isHidden = !shown
        searchBoutton.isHidden = shown
    }
    
}

// MARK: RESET TEXTS
extension HomePageViewController {
    
    /// Reset ingredients text field as empty text
    private func resetIngredientsTextField() {
        ingredientsTextField.text = ""
    }
    
    /// Reset ingredients text view as empty text
    private func resetIndredientsTextView() {
        ingredientsTextView.text = ""
        ingredientsSetInTextView = Set<String>()
    }
    
    /// Reset text field & text view as empty texts
    private func resetTexts() {
        resetIngredientsTextField()
        resetIndredientsTextView()
    }
    
}

// MARK: TEXT FIELD
extension HomePageViewController: UITextFieldDelegate {
    // Dismiss Keyboard by touching anywhere in the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // Dismiss Keyboard by touching return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    // Allows to enter only letters & whitespaces in text field keyboard
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharatersForKeyboard = CharacterSet.letters
        let allowedWhitespacesForKeyboard = CharacterSet.whitespaces
        
        let characterSetForKeyboard = CharacterSet(charactersIn: string)
        return allowedCharatersForKeyboard.isSuperset(of: characterSetForKeyboard) || allowedWhitespacesForKeyboard.isSuperset(of: characterSetForKeyboard)
    }
    
}
