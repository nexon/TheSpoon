//
//  SPNRestaurantListRepository.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 15-11-22.
//

import Foundation

/// An interface that will help us to define the way we implement our List of Restaurant repository
protocol SPNRestaurantListRepository {
    
    /// Reads the list of restaurants.
    ///
    /// - Parameters:
    ///   - parameters: The parameters that we need to send out to the backend
    ///   - completion: Completion block that get called once the request is finished and we get back the response.
    func read(parameters: [String: Any], completion: @escaping (Result<[SPNRestaurantEntity], Error>) -> Void)
    
    /// Send a request to update the favorite option in a restaurant.
    ///
    /// - Parameters:
    ///   - restaurant: The restaurant for which we would update our preference (if it is fav. or not).
    ///   - completion: Completion block that get called once the request is finished and we get back the response.
    func favorite(restaurant: String, completion: @escaping (Result<Bool, Error>) -> Void)
}
