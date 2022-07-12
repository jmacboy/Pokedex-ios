//
//  AdvanceFilterTests.swift
//  Pokedex_iosTests
//
//  Created by Alvaro Choque on 11/7/22.
//
//  AdvancedFilterPokemonTests.swift
//  Pokedex_iosTests
//
//  Created by admin on 7/11/22.
//
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
    var mockTest: MockPokedexService?
    var viewModel: PokemonListViewModel?

    override func setUpWithError() throws {
        mockTest = MockPokedexService()
        viewModel = PokemonListViewModel(pokedexService: MockPokedexService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWeaknessesFilterWithSelectedValues() throws {
        let advancedFilterViewModel = AdvancedFilterPopupViewModel()
        advancedFilterViewModel.selectedWeaknesses = TestResources.filterByWeankessCriteria
        advancedFilterViewModel.pokemonOriginal = TestResources.pokemonRaw

        let result = advancedFilterViewModel.filterByWeaknesses()

        XCTAssertEqual(result.count, 1)
    }

    func testWeaknessesFilterWithNoSelectedValues() throws {
        let advancedFilterViewModel = AdvancedFilterPopupViewModel()
        advancedFilterViewModel.selectedWeaknesses = []
        advancedFilterViewModel.pokemonOriginal = TestResources.pokemonRaw

        let result = advancedFilterViewModel.filterByWeaknesses()

        XCTAssertEqual(result.count, 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
