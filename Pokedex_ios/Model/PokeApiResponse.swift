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
struct Generation: Codable, Equatable {
    let id: Int
    let name: String
    public static func == (lhs: Generation, rhs: Generation) -> Bool {
        return
            lhs.id == rhs.id && lhs.name == rhs.name
    }
}

// MARK: - PokemonDetail
struct PokemonDetail: Codable {
    let name: String
    let height, weight: Int
    let types: [TypeElement]
    var weaknesses: [Weakness]? = []
}

// MARK: - TypeElement
struct TypeElement: Codable, Equatable {
    let type: Generation
    public static func == (lhs: TypeElement, rhs: TypeElement) -> Bool {
            return
                lhs.type == rhs.type
        }
}

// MARK: - Weakness
struct Weakness: Codable {
    let fromType: Generation
    let damageTaken: Double
}

// MARK: - Weakness
struct Weakness: Codable {
    let fromType: Generation
    let damageTaken: Double
}
