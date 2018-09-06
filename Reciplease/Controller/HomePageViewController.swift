//
//  HomePageViewController.swift
//  Reciplease
//
//  Created by Mehdi on 29/07/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {
    // MARK: Properties
    
    // MARK: Outlets
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    // MARK: Actions
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
        
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        resetTexts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    /// Get ingredient from user entred in text field
    ///
    /// - Parameter ingredients: String contained in the text field
    private func getIngredientsFromTextField(ingredients: String?) {
        
        guard let ingredients = ingredients else { return }
        
        if !ingredients.isEmpty {
            
            // Transforming the ingredients in string separated by space to ingredients in array
            let ingredientsInArray = ingredients.convertStringToStringArrayString(separator: [" "])
        
            addIngredientsToTextView(ingredients: ingredientsInArray)
        }
    }
    
    /// Add ingredients to the text view
    ///
    /// - Parameter ingredients: The ingredients stored in string array
    private func addIngredientsToTextView(ingredients: [String]) {
        
        // ingredientsTextView.text + "" => To avoid losing previously entered ingredients after erasing the text field
        var ingredientToList = ingredientsTextView.text + ""

        let nonDuplicatedIngredients = [Any].removeDuplicatedStringArrayItem(stringArray: ingredients)
        
        // Fill ingredients from array to string with new line to present them as list format
        for ingredient in nonDuplicatedIngredients {
            if ingredient.count > 2 && !ingredient.isEmpty {
                // TODO: Check Doubles ingredients ?
                // Check if ingredient already exists in ingredientsTextView.text
                // 1 Transform ingredientsTextView.text to an array
                // OR transform ingredientsTextView.text & ingredientsTextField.text to an array to check all
                
                ingredientToList += "﹆ \(ingredient) \n"
            }
        }
    
        ingredientsTextView.text = ingredientToList
        
        // Dismiss keyboard after add ingredient(s)
        if !ingredientToList.isEmpty {
            view.endEditing(true)
        }
    }
    
    private func removeDuplicatedIngrientsListFromTextView(ingredientsFromTextView: String?) -> [String] {
        guard let ingredientsFromTextView = ingredientsFromTextView else { return [""] }
        
        let ingredientsInArray = ingredientsFromTextView.convertStringToStringArrayString(separator: [" ", "\n"])
        
        let uniqueIngredients = [Any].removeDuplicatedStringArrayItem(stringArray: ingredientsInArray)
        
        return uniqueIngredients
    }
    
    // TODO: To Remove?
//
//    private func checkIfIngridientIsUniq(ingredientsFromTextField: [String], ingredientsFromTextView: String?) -> Bool {
//        guard let ingredientsFromTextView = ingredientsFromTextView else { return false }
//
//        let ingredientInArray = ingredientsFromTextView.convertStringToStringArrayString(separator: ["\n"])
//
//        // TODO: Check Doubles ingredients ?
//        for ingredientInTextView in ingredientInArray {
//            for ingredientInTextField in ingredientsFromTextField {
//
//                let trimmedIngredientInTextView = ingredientInTextView.trimmingCharacters(in: .whitespaces)
//                let trimmedIngredientInTextField = ingredientInTextField.trimmingCharacters(in: .whitespaces)
//                if trimmedIngredientInTextView.lowercased() == trimmedIngredientInTextField.lowercased() {
//                    return false
//                }
//            }
//        }
//
//        return true
//    }

    /// Present confirmation message to delete the ingredients from text view with the possibility to cancel the deletation
    private func clearIngredientsConfirmation() {
        let alertMessage = UIAlertController(title: "Delete all ingredients?", message: "If you erase the ingredients you will not be able to recover them!", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (_) in
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
    
    // MARK: Reset texts
    
    /// Reset ingredients text field as empty text
    private func resetIngredientsTextField() {
        ingredientsTextField.text = ""
    }
    
    /// Reset ingredients text view as empty text
    private func resetIndredientsTextView() {
        ingredientsTextView.text = ""
    }
    
    /// Reset text field & text view as empty texts
    private func resetTexts() {
        resetIngredientsTextField()
        resetIndredientsTextView()
    }
    
    private func setupDelegates() {
        ingredientsTextField.delegate = self
    }

}

// MARK: Text Field
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
