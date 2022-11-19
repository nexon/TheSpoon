//
//  SPNSortingOptions.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 19-11-22.
//

import Foundation

enum SPNSortingOptions: CaseIterable {
    case name
    case rating
    
    var title: String {
        switch self {
        case .name:
            return "Name"
        case .rating:
            return "Rating"
        }
    }
}
