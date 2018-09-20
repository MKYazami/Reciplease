//
//  Helper.swift
//  Reciplease
//
//  Created by Mehdi on 20/09/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//
import UIKit
import Foundation

/// Contains some useful methods generally usable to the project
struct Helper {
    
    private init() { }
    
    /// Allows to open web URL in web browser
    ///
    /// - Parameter url: URL to open
    static func openURLInWebBrowser(url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
