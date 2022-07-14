//
//  GenerationFilterTests.swift
//  Pokedex_iosTests
//
//  Created by admin on 7/14/22.
//

import XCTest
@testable import Pokedex_ios

class GenerationFilterTests: XCTestCase {
    
    var mockTest: MockPokedexService?
    var viewModel: PokemonListViewModel?
    let generationFilterViewModel = GenerationFilterPopupViewModel()
    
    func testGenerationFilterWithSelectedValues() throws {
        generationFilterViewModel.pokemons = TestResources.pokemonRaw
        generationFilterViewModel.selectedGeneration = TestResources.filterByGenerationCriteria

        let result = generationFilterViewModel.filterByGeneration()

        XCTAssertEqual(result.count, 1)
    }
    
    func testGenerationFilterWithNoSelectedValues() throws {
        generationFilterViewModel.pokemons = TestResources.pokemonRaw
        generationFilterViewModel.selectedGeneration = []

        let result = generationFilterViewModel.filterByGeneration()

        XCTAssertEqual(result.count, 3)
    }
    

    override func setUpWithError() throws {
        mockTest = MockPokedexService()
        viewModel = PokemonListViewModel(pokedexService: MockPokedexService())
    }

    override func tearDownWithError() throws {
        
    }

    func testPerformanceExample() throws {
        self.measure {
            
        }
    }

}
