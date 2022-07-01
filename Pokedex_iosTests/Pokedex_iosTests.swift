//
//  Pokedex_iosTests.swift
//  Pokedex_iosTests
//
//  Created by admin on 6/29/22.
//

import XCTest
@testable import Pokedex_ios

let data = PokemonRaw(id: 4, name: "some", generation: Generation(id: 4, name: "gen1"), pokemonDetails: [PokemonDetail(name: "detail1", height: 5, weight: 5, types: [TypeElement(type: Generation(id: 3, name: "gen1"))])])


class MockPokedexService: PokedexServiceProtocol {
    var getPokemonsGotCalled = false
    func getPokemons(completion: @escaping (Bool, [PokemonRaw]?, String?) -> ()) {
        completion(true, [data], nil)
        getPokemonsGotCalled = true
    }
}

class Pokedex_iosTests: XCTestCase {
    let mockTest = MockPokedexService()
    let viewModel = PokemonListViewModel(pokedexService: MockPokedexService())
    
    func testGetPokemonsFromNetwork() {
        viewModel.getPokemons()
        XCTAssertNotEqual(viewModel.pokemons.count, 0)
//        guard let funcCalled = viewModel.pokedexService.getPokemonsGotCalled else {return}
//        XCTAssertTrue(funcCalled)
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
