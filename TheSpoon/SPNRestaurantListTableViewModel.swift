//
//  SPNRestaurantListTableViewModel.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 15-11-22.
//

import Foundation
import UIKit

final class SPNRestaurantListTableViewModel {
    
    // MARK: - Private Properties
    
    private static let imageCache = NSCache<AnyObject, AnyObject>()
    private var entity: SPNRestaurantEntity
    private var task: URLSessionDataTask?
    
    // MARK: - Public Properties
    
    /// The object that identifies the Restaurant as unique
    var identifier: String { entity.id }
    
    /// The name of the Restaurant
    var name: String { entity.name }
    
    /// The full Address for the Restaurant
    var location: String { "\(entity.address.street), \(entity.address.locality) - \(entity.address.country)" }
    
    /// The overall Rating that the Restaurant has.
    var overallRating: Double { entity.ratings.map(\.ratingValue).reduce(0, +) }
    
    /// `true` if the restaurant is a favorite one for the user
    var isFavorite: Bool { entity.isFavorite }
    
    /// The type of food that this restaurant has.
    var type: String { entity.type }
    
    /// The best offer/deal in the Restaurant.
    var bestOffer: String { entity.bestOffer }
    
    /// The price range for this Restaurant.
    var priceRange: String {
        switch Double(Double(entity.priceRange) / 100) {
        case ((0.0)...0.25):
            return "$"
        case (0.26...0.50):
            return "$$"
        case (0.51...0.75):
            return "$$$"
        case (0.76...1):
            return "$$$$"
        default:
            return "$$$$+"
        }
    }
    
    // MARK: - Public Function(s)
    
    /// Initializer
    ///
    /// - Parameter entity: The Entity that represent a Restaurant in the app.
    init(entity: SPNRestaurantEntity) {
        self.entity = entity
    }
    
    /// Download the Restaurant main image.
    /// - Parameter completion: A completion block that get called once it finishes downloading.
    func downloadImage(completion: @escaping (Result<UIImage, Error>) -> Void) {
        let photoEntity = entity.photos.first { $0.resolution == "612x344" }
        guard let url = photoEntity?.url else {
            completion(.failure(SPNError.downloadImage))
            return
        }
        
        if let imageFromCache = Self.imageCache.object(forKey: url as AnyObject),
           let image = imageFromCache as? UIImage {
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        
        task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
               return
            }
            
           guard let data = data, error == nil, let image = UIImage(data: data) else {
               DispatchQueue.main.async {
                   completion(.failure(SPNError.invalidData))
               }
               return
           }
            
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        
        task?.resume()
    }
    
    /// Cancel the download if necessary.
    func cancelDownload() {
        task?.cancel()
    }
    
    /// Updates the restaurant entity with the new favorite value.
    ///
    /// - Parameter favorite: `true` if this restaurant is favorite. `false` otherwise.
    func update(favorite: Bool) {
        entity.update(isFavorite: favorite)
    }
}
