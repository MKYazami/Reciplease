//
//  ListeningActionsProtocols.swift
//  Reciplease
//
//  Created by Mehdi on 01/08/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

/// Used to conform to the view controller that must listen to the get directions actions from the custom view
protocol ListeningGetDirectionsAction {
    func listingAction()
}

/// Used to conform to the view controller that must listen to the selected cell from the custom view cell
protocol ListenToSelectedCell {
    func listingSelection()
}
