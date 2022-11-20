//
//  SPNRestaurantAddressDTO.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 15-11-22.
//

import Foundation

struct SPNRestaurantAddressDTO: Codable {
    let street: String
    let postalCode: String
    let locality: String
    let country: String
}
