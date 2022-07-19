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
    let singlePokemon = PokemonRaw(id: 4, name: "some", generation: Generation(id: 4, name: "gen1"),
     pokemonDetails: [PokemonDetail(name: "detail1", height: 5, weight: 5, types: [TypeElement(type: Generation(id: 3, name: "gen1"))])])

    let pokemonsList: [PokemonRaw] = [
        PokemonRaw(id: 1, name: "some", generation: Generation(id: 4, name: "gen1"),
        pokemonDetails: [PokemonDetail(name: "detail1", height: 5, weight: 5,
        types: [TypeElement(type: Generation(id: 3, name: "gen1"))])]),
        PokemonRaw(id: 2, name: "some", generation: Generation(id: 4, name: "gen1"),
        pokemonDetails: [PokemonDetail(name: "detail1", height: 5, weight: 5,
        types: [TypeElement(type: Generation(id: 12, name: "grass")), TypeElement(type: Generation(id: 6, name: "rock"))])]),
        PokemonRaw(id: 3, name: "some", generation: Generation(id: 4, name: "gen1"),
        pokemonDetails: [PokemonDetail(name: "detail1", height: 5, weight: 5,
        types: [TypeElement(type: Generation(id: 3, name: "gen1"))])]),
        PokemonRaw(id: 4, name: "some", generation: Generation(id: 4, name: "gen1"),
        pokemonDetails: [PokemonDetail(name: "detail1", height: 5, weight: 5,
        types: [TypeElement(type: Generation(id: 12, name: "grass")), TypeElement(type: Generation(id: 6, name: "rock"))])])
    ]

    let filterTypesCriteria: [TypeElement] = [TypeElement(type: Generation(id: 12, name: "grass")),
        TypeElement(type: Generation(id: 6, name: "rock"))]

    let filterHeightsCriteria: [PokemonHeigths] = [.large]

    static let pokemonRaw = [
        PokemonRaw(id: 1, name: "poke1", urlImage: "Url", generation: Generation(id: 1, name: "generation-1"), pokemonDetails: [
            PokemonDetail(name: "poke1", height: 10, weight: 131, types: [
                TypeElement(type: Generation(id: 1, name: "grass"))
            ], weaknesses: [
                Weakness(fromType: Generation(id: 2, name: "fire"), damageTaken: 2.0),
                Weakness(fromType: Generation(id: 5, name: "dragon"), damageTaken: 2.0)
            ])
        ]),
        PokemonRaw(id: 2, name: "poke2", urlImage: "Url", generation: Generation(id: 1, name: "generation-1"), pokemonDetails: [
            PokemonDetail(name: "poke2", height: 25, weight: 450, types: [
                TypeElement(type: Generation(id: 3, name: "water"))
            ], weaknesses: [
                Weakness(fromType: Generation(id: 4, name: "normal"), damageTaken: 0.5)
            ])
        ]),
        PokemonRaw(id: 1, name: "poke2", urlImage: "Url", generation: Generation(id: 1, name: "generation-1"), pokemonDetails: [
            PokemonDetail(name: "poke2", height: 15, weight: 455, types: [
                TypeElement(type: Generation(id: 5, name: "dragon"))
            ], weaknesses: [
                Weakness(fromType: Generation(id: 5, name: "dragon"), damageTaken: 2.0)
            ])
        ])
    ]

    static let filterByWeankessCriteria = [
        TypeElement(type: Generation(id: 2, name: "fire")),
        TypeElement(type: Generation(id: 5, name: "dragon"))
    ]
}
