//
//  SPNRestaurantAddressEntity.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 15-11-22.
//

import Foundation

/// A data structure that represent the Address of a restaurant
struct SPNRestaurantAddressEntity {
    
    /// The Street where the restaurant is located.
    let street: String
    
    /// The postal code for the restaurant
    let postalCode: String
    
    /// The location where the restaurant is.
    let locality: String
    
    /// The country where the restaurant is located.
    let country: String
}
