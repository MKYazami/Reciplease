//
//  ImageNamesEnum.swift
//  Reciplease
//
//  Created by Mehdi on 15/09/2018.
//  Copyright © 2018 Mehdi. All rights reserved.
//

import Foundation

/// Enumering rating stars images names
///
/// - noRating: 0 rating
/// - rating1Of5: 1 rating of 5
/// - rating2Of5: 2 rating of 5
/// - rating3Of5: 3 rating of 5
/// - rating4Of5: 4 rating of 5
/// - rating5Of5: 5 rating of 5
enum RatingStarsImagesNames: String {
    case noRating
    case rating1Of5
    case rating2Of5
    case rating3Of5
    case rating4Of5
    case rating5Of5
}

/// Enum image names that are in the user interface
enum UIImageNames: String {
    case defaultImage
    case Favorite
    case FavoriteSelected
    case clockCircular
    case searcher
}
