//
//  TableViewConfigurator.swift
//  Reciplease
//
//  Created by Mehdi on 05/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import UIKit

/// Contains methods useful for configuring Table View and Table View Cell
struct TableViewConfigurator {
    
    /// Allows to load cell from nib
    ///
    /// - Parameters:
    ///   - nibName: NIB Name
    ///   - cellIdentifier: Cell Reuse Identifier
    ///   - tableView: The Table View concerned to load the Cell
    static func loadCellNib(nibName: String, cellIdentifier: String, tableView: UITableView) {

        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        
    }

}
