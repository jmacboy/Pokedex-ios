//
//  PokeApiResponse.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 29/6/22.
//

import Foundation

// MARK: - PokeApiResponse
struct PokeApiResponse: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    var species: [PokemonRaw]
}

struct PokemonRaw: Codable {
    let id: Int
    let name: String
    var urlImage: String = ""
    let generation: Generation
    var pokemonDetails: [PokemonDetail]

    enum CodingKeys: String, CodingKey {
        case id, name, generation
        case pokemonDetails = "pokemon_details"
    }
}

// MARK: - Generation
struct Generation: Codable {
    let id: Int
    let name: String
}

// MARK: - PokemonDetail
struct PokemonDetail: Codable {
    let name: String
    let height, weight: Int
    let types: [TypeElement]
    var weaknesses: [Weakness]? = []
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let type: Generation
}

// MARK: - Weakness
struct Weakness: Codable {
    let fromType: Generation
    let damageTaken: Double
}
