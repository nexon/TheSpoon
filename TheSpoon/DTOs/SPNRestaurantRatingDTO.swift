//
//  SPNRestaurantRatingDTO.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 15-11-22.
//

import Foundation

struct SPNRestaurantRatingDTO: Codable {
    let name: String
    
    let ratingValue: Double
    let reviewCount: Int
}
