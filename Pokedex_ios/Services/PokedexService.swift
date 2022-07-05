//
//  PokedexService.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 29/6/22.
//

import Foundation
import Apollo

protocol PokedexServiceProtocol {
    func getPokemons(completion: @escaping (Result<[PokemonRaw], Error>) -> Void)
    func getPokemonsImageBy(id: Int) -> String
}

class PokedexService: PokedexServiceProtocol {
    func getPokemons(completion: @escaping (Result<[PokemonRaw], Error>) -> Void) {

        NetworkManager.shared.apollo.fetch(query: HomePageQuery()) { data in
            switch data {
            case .success(let graphResult):
                ConversionHelper.shared.convertFromDataToPokemonStruct(data: graphResult.data!) { data in
                    switch data {
                    case.success(let species):
                        DispatchQueue.main.async {
                            completion(.success(species))
                        }
                    case.failure(let error):
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }

    }

    func getPokemonsImageBy(id: Int) -> String {
        let url = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
        return url
    }
}
