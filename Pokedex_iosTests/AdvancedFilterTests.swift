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
    let advancedFilterViewModel = AdvancedFilterPopupViewModel()
    func testGetPokemonsFilteredByTest() {
        advancedFilterViewModel.selectedTypesForTypes = TestResources.shared.filterTypesCriteria
        advancedFilterViewModel.pokemons = TestResources.shared.pokemonsList
        
        let result = advancedFilterViewModel.filterByTypes()
        
        XCTAssertEqual(result.count, 2)
    }
    
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
//        let advancedFilterViewModel = AdvancedFilterPopupViewModel()
        advancedFilterViewModel.pokemons = TestResources.pokemonRaw
        advancedFilterViewModel.filterByTypes()
        advancedFilterViewModel.selectedWeaknesses = TestResources.filterByWeankessCriteria
//        advancedFilterViewModel.pokemons = TestResources.pokemonRaw

        let result = advancedFilterViewModel.filterByWeaknesses()

        XCTAssertEqual(result.count, 1)
    }

    func testWeaknessesFilterWithNoSelectedValues() throws {
        advancedFilterViewModel.pokemons = TestResources.pokemonRaw
        advancedFilterViewModel.filterByTypes()
        advancedFilterViewModel.selectedWeaknesses = []

        let result = advancedFilterViewModel.filterByWeaknesses()

        XCTAssertEqual(result.count, 3)
    }
    
    func testWeigthFilterWithSelectedValues() throws {
            let advancedFilterViewModel = AdvancedFilterPopupViewModel()
            advancedFilterViewModel.filtered = TestResources.pokemonRaw
            //low weigth
            advancedFilterViewModel.selectedWeigth[0] = true
            let resultLow = advancedFilterViewModel.filterByWeight()
            XCTAssertEqual(resultLow.count, 1)
            //mid weigth
            advancedFilterViewModel.resetFilters()
            advancedFilterViewModel.selectedWeigth[1] = true
            advancedFilterViewModel.filtered = TestResources.pokemonRaw
            let resultMid = advancedFilterViewModel.filterByWeight()
            XCTAssertEqual(resultMid.count, 1)
            // heavy weigth
            advancedFilterViewModel.resetFilters() 
            advancedFilterViewModel.selectedWeigth[2] = true
            advancedFilterViewModel.filtered = TestResources.pokemonRaw
            let resultHeavy = advancedFilterViewModel.filterByWeight()
            XCTAssertEqual(resultHeavy.count, 1)
        }
        

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

