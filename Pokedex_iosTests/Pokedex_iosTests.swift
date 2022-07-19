//
//  Pokedex_iosTests.swift
//  Pokedex_iosTests
//
//  Created by admin on 6/29/22.
//

import XCTest
@testable import Pokedex_ios

class MockPokedexService: PokedexServiceProtocol {
    var getPokemonsGotCalled = false
    func getPokemons(completion: @escaping (Result<[PokemonRaw], Error>) -> Void) {
        completion(.success(TestResources.shared.pokemonsList))
        getPokemonsGotCalled = true
    }

    func getPokemonsImageBy(id: Int) -> String {
        return "some"
    }
}

class PokedexIosTests: XCTestCase {
    let mockTest = MockPokedexService()
    let viewModel = PokemonListViewModel(pokedexService: MockPokedexService())

    func testGetPokemonsFromNetwork() {
        viewModel.getPokemons()
        XCTAssertEqual(viewModel.pokemons.count, 4)
    }

    func testSearchByNameSuccess() {
        viewModel.getPokemons()
        viewModel.searchText = "so"
        viewModel.searchPokemonsByName()
        XCTAssertEqual(viewModel.pokemons.count, 4)
    }

    func testSearchByNameFailure() {
        viewModel.getPokemons()
        viewModel.searchText = "someo"
        viewModel.searchPokemonsByName()
        XCTAssertEqual(viewModel.pokemons.count, 0)
    }

    func testSearchByNameEmpty() {
        viewModel.getPokemons()
        viewModel.searchText = ""
        viewModel.searchPokemonsByName()
        XCTAssertEqual(viewModel.pokemons.count, 4  )
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
