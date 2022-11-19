//
//  SPNRestaurantListController.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 15-11-22.
//

import Foundation

final class SPNRestaurantListController {
    
    // MARK: - Private Properties
    
    private let repository: SPNRestaurantListRepository
    private var items: [SPNRestaurantListTableViewModel]
    
    // MARK: - Public Properties
    
    private(set) var sortingOption: SPNSortingOptions = .name
    
    var numberOfItems: Int { items.count }
    
    // MARK: - Public Function(s)
    
    /// Initializer
    ///
    /// - Parameter repository: The concrete implementation of the Repository where we get the Restaurants
    init(repository: SPNRestaurantListRepository) {
        self.repository = repository
        items = []
    }
    
    /// Obtain Information for an especific row
    ///
    /// - Parameter row: The row you need to get information
    /// - Returns: A `SPNRestaurantListTableViewModel` is the row exist. `nil` if it not exist
    func item(at row: Int) -> SPNRestaurantListTableViewModel? {
        guard row < items.count else { return nil }
        return items[row]
    }
    
    /// Get all the restaurants that we want to display in the list
    ///
    /// - Parameter completion: A completion block that gets called once the request has finished
    func read(completion: @escaping (Result<Void, Error>) -> Void) {
        repository.read(parameters: [:]) { [weak self] result in
            guard let strongSelf = self else {
                completion(.success(()))
                return
            }
            
            switch result {
            case let .success(items):
                strongSelf.items = items
                    .map(SPNRestaurantListTableViewModel.init)
                strongSelf.sort(by: strongSelf.sortingOption)
                
                completion(.success(()))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    /// A sorting function that will sort the items
    ///
    /// - Parameter option: The sorting option.
    func sort(by option: SPNSortingOptions) {
        sortingOption = option
        
        items
            .sort { obj1, obj2 in
                if sortingOption == .name {
                    return obj1.name < obj2.name
                } else {
                    return obj1.overallRating > obj2.overallRating
                }
            }
    }
    
    func toggleFavorite(restaurant id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.favorite(restaurant: id) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case let .success(isFavorite):
                strongSelf.items.first { $0.identifier == id }?.update(favorite: isFavorite)
                completion(.success(()))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
