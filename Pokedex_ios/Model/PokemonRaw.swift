//
//  Pokemon.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 29/6/22.
//

import Foundation

struct PokemonRaw: Codable {
    let name: String
    let url: String
}

/*
 // MARK: - POKEMON
 struct Pokemon: Codable {
     let id: Int
     let name: String
     let generation: Generation
     let pokemonDetails: [PokemonDetail]

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
 }

 // MARK: - TypeElement
 struct TypeElement: Codable {
     let type: Generation
 }

 */
