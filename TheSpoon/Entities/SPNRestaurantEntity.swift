//
//  SPNRestaurantEntity.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 15-11-22.
//

import Foundation

/// A Data structure that represent a Restaurant in the App
struct SPNRestaurantEntity {
    
    /// The name of the restaurant
    let name: String
    
    /// The identifier for the restaurant (Unique)
    let id: String
    
    /// Where the restaurant is located
    let address: SPNRestaurantAddressEntity
    
    /// An array of photos (main Photos) of the restaurant.
    /// Different resolutions
    let photos: [SPNRestaurantPhotoEntity]
    
    /// The rating that the restaurant has.
    let ratings: [SPNRestaurantRatingEntity]
    
    /// The price range for the restaurant
    let priceRange: Int
    
    /// The type of cousine that the restaurant serves
    let type: String
    
    /// The best offer that the restaurant has right now.
    let bestOffer: String
    
    /// If the restaurant is a favorite one for the User of the app.
    var isFavorite: Bool
    
    /// Updates the current restaurant with the favorite option for the user.
    ///
    /// - Parameter isFavorite: `true` if it is favorite. `false` otherwise.
    mutating func update(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
}
