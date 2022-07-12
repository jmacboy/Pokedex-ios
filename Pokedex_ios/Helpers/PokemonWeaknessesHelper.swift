//
//  PokemonWeaknesses.swift
//  Pokedex_ios
//
//  Created by admin on 7/5/22.
//

import Foundation

class PokemonWeaknessesHelper {

    static let shared = PokemonWeaknessesHelper()

    // these values are related to the type, they are in the same order as variable declarations

    private let damageRelationsValues = [
        [ 1, 2, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ],  // normal
        [ 1, 1, 2, 1, 1, 0.5, 0.5, 1, 1, 1, 1, 1, 1, 2, 1, 1, 0.5, 2 ],  // fighting
        [ 1, 0.5, 1, 1, 0, 2, 0.5, 1, 1, 1, 1, 0.5, 2, 1, 2, 1, 1, 1 ],  // flying
        [ 1, 0.5, 1, 0.5, 2, 1, 0.5, 1, 1, 1, 1, 0.5, 1, 2, 1, 1, 1, 0.5 ],  // poison
        [ 1, 1, 1, 0.5, 1, 0.5, 1, 1, 1, 1, 2, 2, 0, 1, 2, 1, 1, 1 ],  // ground
        [ 0.5, 2, 0.5, 0.5, 2, 1, 1, 1, 2, 0.5, 2, 2, 1, 1, 1, 1, 1, 1 ],  // rock
        [ 1, 0.5, 2, 1, 0.5, 2, 1, 1, 1, 2, 1, 0.5, 1, 1, 1, 1, 1, 1 ],  // bug
        [ 0, 0, 1, 0.5, 1, 1, 0.5, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1 ],  // ghost
        [ 0.5, 2, 0.5, 0, 2, 0.5, 0.5, 1, 0.5, 2, 1, 0.5, 1, 0.5, 0.5, 0.5, 1, 0.5 ],  // steel
        [ 1, 1, 1, 1, 2, 2, 0.5, 1, 0.5, 0.5, 2, 0.5, 1, 1, 0.5, 1, 1, 0.5 ],  // fire
        [ 1, 1, 1, 1, 1, 1, 1, 1, 0.5, 0.5, 0.5, 2, 2, 1, 0.5, 1, 1, 1 ],  // water
        [ 1, 1, 2, 2, 0.5, 1, 2, 1, 1, 2, 0.5, 0.5, 0.5, 1, 2, 1, 1, 1 ],  // grass
        [ 1, 1, 0.5, 1, 2, 1, 1, 1, 0.5, 1, 1, 1, 0.5, 1, 1, 1, 1, 1 ],  // electric
        [ 1, 0.5, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 0.5, 1, 1, 2, 1 ],  // psychic
        [ 1, 2, 1, 1, 1, 2, 1, 1, 2, 2, 1, 1, 1, 1, 0.5, 1, 1, 1 ],  // ice
        [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.5, 0.5, 0.5, 0.5, 1, 2, 2, 1, 2 ],  // dragon
        [ 1, 2, 1, 1, 1, 1, 2, 0.5, 1, 1, 1, 1, 1, 0, 1, 1, 0.5, 2 ],  // dark
        [ 1, 0.5, 1, 2, 1, 1, 0.5, 1, 2, 1, 1, 1, 1, 1, 1, 0, 0.5, 1 ] // fairy
    ]

    func getPokemonWeaknessesByType(_ types: [TypeElement]) -> [Weakness] {

        var auxDamageValues = [[Double]]()
        types.forEach {
            let pokemonTypeId = $0.type.id - 1
            auxDamageValues.append(damageRelationsValues[pokemonTypeId])
        }

        if types.count == 1 {
            return createWeaknessesArrayWithDamageValues(auxDamageValues[0])
        }

        var resultDamageValues = [Double]()

        for i in 0 ..< damageRelationsValues[0].count {
            resultDamageValues.append((auxDamageValues[0][i] * auxDamageValues[1][i]))
        }
        return createWeaknessesArrayWithDamageValues(resultDamageValues)

    }

    private func createWeaknessesArrayWithDamageValues(_ damageRow: [Double]) -> [Weakness] {
        var weaknesses = [Weakness]()
        for (index, damageValue) in damageRow.enumerated() {
            let type = ConstantVariables.pokemonTypes[index].type
            weaknesses.append(Weakness(fromType: type, damageTaken: damageValue))
        }
        return weaknesses
    }

}
