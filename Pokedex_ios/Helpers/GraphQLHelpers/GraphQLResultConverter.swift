//
//  GraphQLResultConverter.swift
//  Pokedex_ios
//
//  Created by Yawar Valeriano on 7/1/22.
//

import Foundation


class ConversionHelper {
    static let shared = ConversionHelper()
    
    private let pokemonImageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/%d.png"
    
    func convertFromDataToPokemonStruct(data: HomePageQuery.Data, completion: @escaping(Result<[PokemonRaw], Error>) -> Void) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data.jsonObject)
            var decode: DataClass = try JSONDecoder().decode(DataClass.self, from: jsonData)
            for index in 0..<decode.species.count {
        
                decode.species[index].urlImage = String(format: pokemonImageURL, decode.species[index].id)
            }
            completion(.success(decode.species))
        } catch {
            completion(.failure(error))
        }
        
    }
}
