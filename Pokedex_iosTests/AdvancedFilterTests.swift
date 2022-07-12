//
//  AdvanceFilterTests.swift
//  Pokedex_iosTests
//
//  Created by Alvaro Choque on 11/7/22.
//

import Foundation

import XCTest
@testable import Pokedex_ios

class AdvancedFilterTests: XCTestCase {
    func testGetPokemonsFilteredByTest() {
        let advancedFilterViewModel = AdvancedFilterPopupViewModel()
        advancedFilterViewModel.selectedTypesForTypes = TestResources.shared.filterTypesCriteria
        
        let result = advancedFilterViewModel.filterByTypes(pokeData: TestResources.shared.pokemonsList)
        
        XCTAssertEqual(result.count, 2)
    }
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
