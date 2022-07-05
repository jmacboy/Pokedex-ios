//
//  GraphQLResultConverter.swift
//  Pokedex_ios
//
//  Created by admin on 7/1/22.
//

import Foundation

class ConversionHelper {
    static let shared = ConversionHelper()

    func convertFromDataToPokemonStruct(data: HomePageQuery.Data, completion: @escaping(Result<[PokemonRaw], Error>) -> Void) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data.jsonObject)
            var decode: DataClass = try JSONDecoder().decode(DataClass.self, from: jsonData)
            for index in 0..<decode.species.count {

                decode.species[index].urlImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(decode.species[index].id).png"
            }
            completion(.success(decode.species))
        } catch {
            completion(.failure(error))
        }

    }
}
