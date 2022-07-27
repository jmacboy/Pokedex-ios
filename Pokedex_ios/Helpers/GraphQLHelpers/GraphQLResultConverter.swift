//
//  GraphQLResultConverter.swift
//  Pokedex_ios
//
//  Created by Yawar Valeriano on 7/1/22.
//

import Foundation

class ConversionHelper {

    static let shared = ConversionHelper()

    func convertFromDataToPokemonStruct(data: HomePageQuery.Data, completion: @escaping(Result<[PokemonRaw], Error>) -> Void) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data.jsonObject)
            var decode: DataClass = try JSONDecoder().decode(DataClass.self, from: jsonData)
            for index in 0..<decode.species.count {
                let pokemonDetails = decode.species[index].pokemonDetails[0]
                decode.species[index].urlImage = String(format: ConstantVariables.pokemonImageURL, decode.species[index].id)
                decode.species[index].pokemonDetails[0].weaknesses = PokemonWeaknessesHelper.shared.getPokemonWeaknessesByType(pokemonDetails.types)
            }
            completion(.success(decode.species))
        } catch {
            completion(.failure(error))
        }

    }

    func convertFromDataToPokemonStatsStruct(data: PokemonDetailsStatsQuery.Data, completion: @escaping(Result<PokemonDetailStats, Error>) -> Void) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data.jsonObject)
            let decode: StatsDataClass = try JSONDecoder().decode(StatsDataClass.self, from: jsonData)
            completion(.success(decode.pokemonDetail))
        } catch {
            completion(.failure(error))
        }

    }
}
