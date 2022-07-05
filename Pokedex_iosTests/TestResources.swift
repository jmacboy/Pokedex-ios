//
//  TestResources.swift
//  Pokedex_iosTests
//
//  Created by Alvaro Choque on 4/7/22.
//

import Foundation
@testable import Pokedex_ios

class TestResources {

    static let shared = TestResources()
    let singlePokemon = PokemonRaw(id: 4, name: "some", generation: Generation(id: 4, name: "gen1"), pokemonDetails: [PokemonDetail(name: "detail1", height: 5, weight: 5, types: [TypeElement(type: Generation(id: 3, name: "gen1"))])])
}
