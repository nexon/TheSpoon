//
//  SPNRestaurantRatingEntity.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 18-11-22.
//

import Foundation

/// A data structure that represent a Rating from a company.
struct SPNRestaurantRatingEntity {
    
    /// The company that rate the restaurant.
    let name: String
    
    /// The overall rating for this restaurant from the Company.
    let ratingValue: Double
    
    /// Tottal amount of reviews for this restaurant.
    let reviewCount: Int
}
