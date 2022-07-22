//
//  ConstantVariables.swift
//  Pokedex_ios
//
//  Created by Yawar Valeriano on 7/4/22.
//

import Foundation

class ConstantVariables {
    static let pokeApiEndpoint = "https://beta.pokeapi.co/graphql/v1beta"
    static let pokemonImageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/%d.png"
    static let pokeImageHeader = "PokeballSVG"
    static var applyButtonColor = "apply-button"
    static let pokemonTypes = [
        TypeElement(type: Generation(id: 1, name: "normal")),
        TypeElement(type: Generation(id: 2, name: "fighting")),
        TypeElement(type: Generation(id: 3, name: "flying")),
        TypeElement(type: Generation(id: 4, name: "poison")),
        TypeElement(type: Generation(id: 5, name: "ground")),
        TypeElement(type: Generation(id: 6, name: "rock")),
        TypeElement(type: Generation(id: 7, name: "bug")),
        TypeElement(type: Generation(id: 8, name: "ghost")),
        TypeElement(type: Generation(id: 9, name: "steel")),
        TypeElement(type: Generation(id: 10, name: "fire")),
        TypeElement(type: Generation(id: 11, name: "water")),
        TypeElement(type: Generation(id: 12, name: "grass")),
        TypeElement(type: Generation(id: 13, name: "electric")),
        TypeElement(type: Generation(id: 14, name: "psychic")),
        TypeElement(type: Generation(id: 15, name: "ice")),
        TypeElement(type: Generation(id: 16, name: "dragon")),
        TypeElement(type: Generation(id: 17, name: "dark")),
        TypeElement(type: Generation(id: 18, name: "fairy"))
    ]
    static let pokemonGenerations = [
        GenerationFilter(name: "Generation I", description: "generation-i"),
        GenerationFilter(name: "Generation II", description: "generation-ii"),
        GenerationFilter(name: "Generation III", description: "generation-iii"),
        GenerationFilter(name: "Generation IV", description: "generation-iv"),
        GenerationFilter(name: "Generation V", description: "generation-v"),
        GenerationFilter(name: "Generation VI", description: "generation-vi"),
        GenerationFilter(name: "Generation VII", description: "generation-vii"),
        GenerationFilter(name: "Generation VIII", description: "generation-viii")
    ]
   static let pokemonWeight = [
    "low",
    "mid",
    "heavy"
   ]
    static let inicialWeight = 0
    static let LowWeight  = 132
    static let HeavyWeight =  451
    static let pokemonHeights: [PokemonHeigths] = [.small, .medium, .large]
    
    static let applyButtonColor = "apply-button"
    static let backgroundWhite = "background-white"
}
