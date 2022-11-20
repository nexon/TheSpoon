//
//  TestSPNRestaurantListTableViewModel.swift
//  TheSpoonTests
//
//  Created by Alberto Lagos on 20-11-22.
//

@testable import TheSpoon
import XCTest

final class TestSPNRestaurantListTableViewModel: XCTestCase {
    let entity = SPNRestaurantEntity(name: "Restaurant 1",
                                     id: "1",
                                     address: .init(street: "Street 1", postalCode: "123456", locality: "Paris", country: "France"),
                                     photos: [], ratings: [.init(name: "TripAdvisor", ratingValue: 25.2, reviewCount: 34)],
                                     priceRange: 70,
                                     type: "American",
                                     bestOffer: "40% off - Black Friday",
                                     isFavorite: false)
    
    func testIdentifier() {
        let sut = SPNRestaurantListTableViewModel(entity: entity)
        
        XCTAssertEqual(sut.identifier, "1")
    }
    
    func testName() {
        let sut = SPNRestaurantListTableViewModel(entity: entity)
        
        XCTAssertEqual(sut.name, "Restaurant 1")
    }
    
    func testAddress() {
        let sut = SPNRestaurantListTableViewModel(entity: entity)
        
        XCTAssertEqual(sut.location, "\(entity.address.street), \(entity.address.locality) - \(entity.address.country)")
    }
    
    func testOverallRatings() {
        let sut = SPNRestaurantListTableViewModel(entity: entity)
        
        XCTAssertEqual(sut.overallRating, 25.2)
    }
    
    func testCousineType() {
        let sut = SPNRestaurantListTableViewModel(entity: entity)
        
        XCTAssertEqual(sut.type, "American")
    }
    
    func testBestOffer() {
        let sut = SPNRestaurantListTableViewModel(entity: entity)
        
        XCTAssertEqual(sut.bestOffer, "40% off - Black Friday")
    }
    
    func testPriceRange() {
        let sut = SPNRestaurantListTableViewModel(entity: entity)
        
        XCTAssertEqual(sut.priceRange, "$$$")
    }
    
    func testUpdateFavorite() {
        let sut = SPNRestaurantListTableViewModel(entity: entity)
        XCTAssertFalse(sut.isFavorite)
        sut.update(favorite: true)
        XCTAssert(sut.isFavorite)
    }
}
