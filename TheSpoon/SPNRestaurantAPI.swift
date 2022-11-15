//
//  SPNRestaurantAPI.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 14-11-22.
//

import Foundation

final class SPNRestaurantAPI: SPNRestaurantStore {
    
    // MARK: - Private Properties
    
    private let manager = URLSession.shared
    private var task: URLSessionDataTask?
    
    func read(parameters: [String: Any], completion: @escaping (Result<[SPNRestaurantDTO], Error>) -> Void) {
        guard let url = URL(string: "https://alanflament.github.io/TFTest/test.json") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        task?.cancel()
        
        task = manager.dataTask(with: urlRequest) { data, response, error in
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            guard let payload = data else { fatalError("Error while fetching data") }
            guard let data = data else {
                completion(.failure(NSError(domain: "SPN", code: -1)))
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
}
