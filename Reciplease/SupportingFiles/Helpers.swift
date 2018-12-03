//
//  Helpers.swift
//  Reciplease
//
//  Created by Mehdi on 20/09/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//
import UIKit
import Foundation

/// Contains some useful methods, generally usable to the project
struct Helper {
    
    private init() {}
    
    /// Allows to open web URL in web browser
    ///
    /// - Parameter url: URL to open
    static func openURLInWebBrowser(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    /// Allows to set range of text view in custom recipe view detail
    ///
    /// - Parameter recipeViewDetail: reciped detail view to set
    static func setTextViewScrollRangeInRecipeViewDetail(recipeViewDetail: RecipeDetailView) {
        recipeViewDetail.recipeTextView.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
    /// Allows to display alert message with simple action title to remove alert message
    ///
    /// - Parameters:
    ///   - title: alert title
    ///   - message: alert message
    ///   - actionTitle: action title (as: Okay, Understand…)
    ///   - viewController: the view controller that presents modally
    static func alertMessage(title: String, message: String, actionTitle: String, on viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
        alert.addAction(action)
        viewController.present(alert, animated: true)
    }
    
}
