//
//  SPNRestaurantDTO.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 14-11-22.
//

import Foundation

struct SPNRestaurantDTO: Codable {
    
    // MARK: - Enums
    
    enum CodingKeys: String, CodingKey {
        case name
        case id = "uuid"
        case servesCuisine
        case priceRange
        case currenciesAccepted
        case aggregateRatings
        case bestOffer
        case address
    }
    
    let name: String
    let id: String
    let servesCuisine: String
    let priceRange: Int
    let currenciesAccepted: String
    let address: SPNRestaurantAddressDTO
    let aggregateRatings: [SPNRestaurantRatingDTO]
    let bestOffer: SPNRestaurantBestOfferDTO
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(String.self, forKey: .id)
        servesCuisine = try container.decode(String.self, forKey: .servesCuisine)
        priceRange = try container.decode(Int.self, forKey: .priceRange)
        currenciesAccepted = try container.decode(String.self, forKey: .currenciesAccepted)
        address = try container.decode(SPNRestaurantAddressDTO.self, forKey: .address)
        bestOffer = try container.decode(SPNRestaurantBestOfferDTO.self, forKey: .bestOffer)
        
        let ratings = try container.decode(SPNRestaurantAggregateRatingsDTO.self, forKey: .aggregateRatings)
        aggregateRatings = ratings.array
        
    }
}
