//
//  SPNRestaurantStore.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 14-11-22.
//

import Foundation

protocol SPNRestaurantStore {
    func read(parameters: [String: Any], completion: @escaping (Result<[SPNRestaurantDTO], Error>) -> Void)
}
