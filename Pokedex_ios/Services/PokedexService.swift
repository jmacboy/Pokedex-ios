//
//  PokedexService.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 29/6/22.
//

import Foundation

protocol PokedexServiceProtocol {
    func getPokemons(completion: @escaping (_ success: Bool, _ results: [PokemonRaw]?, _ error: String?) -> ())
}

class PokedexService: PokedexServiceProtocol {
    func getPokemons(completion: @escaping (Bool, [PokemonRaw]?, String?) -> ()) {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else {return}
        
        NetworkManager.shared.get(PokeApiResponse.self, from: url){result in
    
            switch result {
            case .success(let responseData):
                completion(true, responseData.results, nil)
            case .failure(let error):
                completion(false, nil, "Something went wrong: \(error)")
            }
        }
    }
}
