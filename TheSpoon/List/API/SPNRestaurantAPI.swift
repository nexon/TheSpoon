//
//  SPNRestaurantAPI.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 14-11-22.
//

import Foundation

/// Concrete implementation of `SPNRestaurantStore`
final class SPNRestaurantAPI: SPNRestaurantStore {
    
    // MARK: - Private Properties
    
    private let manager = URLSession.shared
    private var task: URLSessionDataTask?
    
    func read(parameters: [String: Any], completion: @escaping (Result<[SPNRestaurantDTO], Error>) -> Void) {
        guard let url = URL(string: "https://alanflament.github.io/TFTest/test.json") else {
            completion(.failure(SPNError.noURL))
            return
        }

        task?.cancel()
        
        task = manager.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure(SPNError.fetchingFailed))
                return
            }
            
            guard let data = data else {
                completion(.failure(SPNError.invalidData))
                return
            }
            
            do {
                let object = try JSONDecoder().decode(SPNRestaurantPayloadDTO.self, from: data)
                completion(.success(object.data))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        task?.resume()
    }
    
    func favorite(restaurant: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        var favoriteRestaurants = UserDefaults.standard.object(forKey: "FAVORITE_RESTAURANTS") as? [String] ?? []
        
        if favoriteRestaurants.contains(restaurant) {
            favoriteRestaurants.removeAll { $0 == restaurant }
        } else {
            favoriteRestaurants.append(restaurant)
        }
        
        UserDefaults.standard.set(favoriteRestaurants, forKey: "FAVORITE_RESTAURANTS")
        
        completion(.success(favoriteRestaurants.contains(restaurant)))
    }
}
