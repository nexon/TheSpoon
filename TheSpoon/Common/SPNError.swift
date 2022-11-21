//
//  SPNError.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 19-11-22.
//

import Foundation

enum SPNError: LocalizedError {
    case downloadImage
    case invalidData
    case noURL
    case fetchingFailed
    case noData
    
    var errorDescription: String? {
        switch self {
        case .downloadImage:
            return "Error trying to download the image."
        case .invalidData:
            return "No valid data."
        case .noURL:
            return "Invalid URL."
        case .fetchingFailed:
            return "Error fetching the Information"
        case .noData:
            return "No Data"
        }
    }
}
