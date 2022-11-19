//
//  SPNRestaurantListDependencyContainer.swift
//  TheSpoon
//
//  Created by Alberto Lagos on 15-11-22.
//

import Foundation

struct SPNRestaurantListDependencyContainer: HasRestaurantRepository, HasRestaurantStore {
    let restaurantRepository: SPNRestaurantListRepository
    let restaurantStore: SPNRestaurantStore
    
    init() {
        restaurantStore = SPNRestaurantAPI()
        restaurantRepository = SPNRestaurantListRemoteRepository(store: restaurantStore)
    }
}
