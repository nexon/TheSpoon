//
//  SPNRestaurantAggregateRatingsDTO.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 15-11-22.
//

import Foundation

struct SPNRestaurantAggregateRatingsDTO: Codable {
    var array: [SPNRestaurantRatingDTO]
        
    // Define DefinitionKeys type needed for creating
    // decoding container from JSONDecoder
    private struct DefinitionKeys: CodingKey {

        // Use for string-keyed dictionary
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        // Use for integer-keyed dictionary
        var intValue: Int?
        init?(intValue: Int) {
            // We are not using this, thus just return nil
            return nil
        }
    }
    
    private struct RatingDetails: Codable {
        let ratingValue: Double
        let reviewCount: Int
    }

    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: DefinitionKeys.self)

            array = try container.allKeys.compactMap { key in
                guard let name = DefinitionKeys(stringValue: key.stringValue) else { return nil }
                let details = try container.decode(RatingDetails.self, forKey: name)
                
                return SPNRestaurantRatingDTO(name: name.stringValue,
                                              ratingValue: details.ratingValue,
                                              reviewCount: details.reviewCount)
            }

        }
}
