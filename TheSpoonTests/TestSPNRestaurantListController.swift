//
//  TestSPNRestaurantListController.swift
//  TheSpoonTests
//
//  Created by Alberto Lagos on 20-11-22.
//

@testable import TheSpoon

import XCTest

final class TestSPNRestaurantListController: XCTestCase {

    func testLoadItems() {
        let sut = SPNRestaurantListController(repository: SPNRestaurantListMockRepository())
        
        let expectation = expectation(description: "Test Load Items")
        sut.read { [weak sut] result in
            expectation.fulfill()
            XCTAssertEqual(sut?.numberOfItems, 6)
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testSortBy() {
        let sut = SPNRestaurantListController(repository: SPNRestaurantListMockRepository())
        
        let expectation = expectation(description: "Test Load Items")
        sut.read { [weak sut] result in
            expectation.fulfill()
            XCTAssertEqual(sut?.item(at: 0)?.name, "Restaurant 1")
            XCTAssertEqual(sut?.item(at: 0)?.overallRating, 25.2)
            sut?.sort(by: .rating)
            XCTAssertEqual(sut?.item(at: 0)?.name, "Restaurant 6")
            XCTAssertEqual(sut?.item(at: 0)?.overallRating, 25.7)
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testItemAt() {
        let sut = SPNRestaurantListController(repository: SPNRestaurantListMockRepository())
        
        let expectation = expectation(description: "Test Load Items")
        sut.read { [weak sut] result in
            expectation.fulfill()
            XCTAssertNotNil(sut?.item(at: 0))
            XCTAssertNotNil(sut?.item(at: 5))
            XCTAssertNil(sut?.item(at: 6))
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testFavoriteToggle() {
        let sut = SPNRestaurantListController(repository: SPNRestaurantListMockRepository())
        
        let expectation = expectation(description: "Test Load Items")
        sut.read { [weak sut] result in
            guard let strongSut = sut else {
                XCTFail("\(#function) - \(#file): Error make SUT strong")
                return
            }
            expectation.fulfill()
            XCTAssertFalse(strongSut.item(at: 0)!.isFavorite)
            strongSut.toggleFavorite(restaurant: strongSut.item(at: 0)!.identifier) { [weak strongSut] favoriteResult in
                XCTAssert(strongSut!.item(at: 0)!.isFavorite)
            }
        }
        
        waitForExpectations(timeout: 5)
    }

}
