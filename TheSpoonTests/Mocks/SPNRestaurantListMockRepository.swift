//
//  SPNRestaurantListMockRepository.swift
//  TheSpoonTests
//
//  Created by Alberto Lagos on 20-11-22.
//

@testable import TheSpoon

final class SPNRestaurantListMockRepository: SPNRestaurantListRepository {
    func read(parameters: [String : Any], completion: @escaping (Result<[TheSpoon.SPNRestaurantEntity], Error>) -> Void) {
        completion(
            .success(
                [
                    SPNRestaurantEntity(name: "Restaurant 1", id: "1", address: .init(street: "Street 1", postalCode: "123456", locality: "Paris", country: "France"), photos: [], ratings: [.init(name: "TripAdvisor", ratingValue: 25.2, reviewCount: 34)], priceRange: 70, type: "American", bestOffer: "40% off - Black Friday", isFavorite: false),
                    SPNRestaurantEntity(name: "Restaurant 2", id: "2", address: .init(street: "Street 2", postalCode: "123456", locality: "Paris", country: "France"), photos: [], ratings: [.init(name: "TripAdvisor", ratingValue: 25.3, reviewCount: 34)], priceRange: 70, type: "American", bestOffer: "40% off - Black Friday", isFavorite: false),
                    SPNRestaurantEntity(name: "Restaurant 3", id: "3", address: .init(street: "Street 3", postalCode: "123456", locality: "Paris", country: "France"), photos: [], ratings: [.init(name: "TripAdvisor", ratingValue: 25.4, reviewCount: 34)], priceRange: 70, type: "American", bestOffer: "40% off - Black Friday", isFavorite: false),
                    SPNRestaurantEntity(name: "Restaurant 4", id: "4", address: .init(street: "Street 4", postalCode: "123456", locality: "Paris", country: "France"), photos: [], ratings: [.init(name: "TripAdvisor", ratingValue: 25.5, reviewCount: 34)], priceRange: 70, type: "American", bestOffer: "40% off - Black Friday", isFavorite: false),
                    SPNRestaurantEntity(name: "Restaurant 5", id: "5", address: .init(street: "Street 5", postalCode: "123456", locality: "Paris", country: "France"), photos: [], ratings: [.init(name: "TripAdvisor", ratingValue: 25.6, reviewCount: 34)], priceRange: 70, type: "American", bestOffer: "40% off - Black Friday", isFavorite: false),
                    SPNRestaurantEntity(name: "Restaurant 6", id: "6", address: .init(street: "Street 6", postalCode: "123456", locality: "Paris", country: "France"), photos: [], ratings: [.init(name: "TripAdvisor", ratingValue: 25.7, reviewCount: 34)], priceRange: 70, type: "American", bestOffer: "40% off - Black Friday", isFavorite: false)
                ]
            )
        )
    }
    
    func favorite(restaurant: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
}
