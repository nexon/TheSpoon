//
//  SPNRestaurantListRemoteRepository.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 15-11-22.
//

import Foundation

struct SPNRestaurantListRemoteRepository: SPNRestaurantListRepository {
    
    // MARK: - Private Properties
    
    private let store: SPNRestaurantStore
    
    /// Initializer.
    ///
    /// - Parameter store: The store that will be the datasource for getting the information that we need.
    init(store: SPNRestaurantStore = SPNRestaurantAPI()) {
        self.store = store
    }
    
    func read(parameters: [String : Any], completion: @escaping (Result<[SPNRestaurantEntity], Error>) -> Void) {
        store.read(parameters: parameters) { result in
            switch result {
            case .success(let items):
                completion(.success(items.map(\.entity)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func favorite(restaurant: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        store.favorite(restaurant: restaurant, completion: completion)
    }
}

// MARK: - <SPNRestaurantDTO>

private extension SPNRestaurantDTO {
    var entity: SPNRestaurantEntity {
        SPNRestaurantEntity(name: name,
                            id: id,
                            address: address.entity,
                            photos: photos.map(\.entity),
                            ratings: aggregateRatings.map(\.entity),
                            priceRange: priceRange,
                            type: servesCuisine,
                            bestOffer: bestOffer.name,
                            isFavorite: false)
    }
}

// MARK: - <SPNRestaurantAddressDTO>

private extension SPNRestaurantAddressDTO {
    var entity: SPNRestaurantAddressEntity {
        SPNRestaurantAddressEntity(street: street,
                                   postalCode: postalCode,
                                   locality: locality,
                                   country: country)
    }
}

// MARK: - <SPNRestaurantPhotoDTO>

private extension SPNRestaurantPhotoDTO {
    var entity: SPNRestaurantPhotoEntity {
        SPNRestaurantPhotoEntity(resolution: resolution, url: url)
    }
}

// MARK: - <SPNRestaurantRatingDTO>

private extension SPNRestaurantRatingDTO {
    var entity: SPNRestaurantRatingEntity {
        SPNRestaurantRatingEntity(name: name, ratingValue: ratingValue, reviewCount: reviewCount)
    }
}
