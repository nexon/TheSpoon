//
//  SPNRestaurantDetailItemType.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 19-11-22.
//

import UIKit

enum SPNRestaurantDetailItemType {
    case priceRange
    case location
    case typeCousine
    
    var image: UIImage? {
        switch self {
        case .priceRange:
            return UIImage(named: "cash")
        case .location:
            return UIImage(named: "location")
        case .typeCousine:
            return UIImage(named: "food")
        }
    }
}
