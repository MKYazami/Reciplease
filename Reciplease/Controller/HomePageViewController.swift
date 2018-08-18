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
    }
    
    @IBAction func clearIngredients() {
        self.ingredientsTextView.text = ""
        
    }
        
    @IBAction func searchRecipes() {
        
    }
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        delegatesSetup()
        resetTextsViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func getIngredientsFromTextField(ingredients: String?) {
        guard let ingredients = ingredients else {
            return
        }
        
        if !ingredients.isEmpty {
            let ingredientsInArray = ingredients.components(separatedBy: [" "])
        
            addIngredientsToList(ingredients: ingredientsInArray)
        }
    }
    
    private func addIngredientsToList(ingredients: [String]) {
        // ingredientsTextView.text + "" => To avoid losing previously entered ingredients after erasing the text field
        var ingredientToList = ingredientsTextView.text + ""
        
        for ingredient in ingredients {
            if ingredient.count > 2 && !ingredient.isEmpty  {
                ingredientToList += "﹆ \(ingredient) \n"
            }
        }
        
        ingredientsTextView.text = ingredientToList
    }
    
    private func resetTextsViews() {
        ingredientsTextField.text = ""
        ingredientsTextView.text = ""
    }
    
    private func alertMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    private func delegatesSetup() {
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
