//
//  AdvancedFilterPopupViewModel.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 5/7/22.
//

import Foundation

protocol ReevaluateDataProtocol: AnyObject {
    func reevaluate(pokemons: [PokemonRaw])
}

class AdvancedFilterPopupViewModel {

    var filtered = [PokemonRaw]()
    var selectedWeaknesses = [TypeElement]()
    var delegate: ReevaluateDataProtocol?
    var closePopup: (() -> Void)?
    var pokemons = [PokemonRaw]()
    var selectedTypesForTypes = [TypeElement]()
    var selectedWeight = [false, false, false]

    func applyFilters() {
        closePopup?()
        // Do not rearrange the following filters functions
        filterByTypes()
        filterByWeaknesses()
        filterByWeight()
        delegate?.reevaluate(pokemons: filtered)
    }

    func resetFilters() {
        // Make all the logic for reset the filters
        selectedTypesForTypes.removeAll()
        selectedWeaknesses.removeAll()
        selectedWeight = Array(repeating: false, count: selectedWeight.count)
    }
    private func checkAllTypes(arr: [TypeElement], target: [TypeElement]) -> Bool {
        target.allSatisfy({ type in
            return arr.contains(where: { tarType in
                tarType == type
            })
        })
    }
    @discardableResult
    func filterByTypes() -> [PokemonRaw] {
        if selectedTypesForTypes.isEmpty {
            filtered = pokemons
            return pokemons
        }
        filtered = pokemons.filter({pokemon in
            return self.checkAllTypes(arr: pokemon.pokemonDetails[0].types, target: selectedTypesForTypes)
        })
        return filtered
    }

    @discardableResult
    func filterByWeaknesses() -> [PokemonRaw] {
        if !selectedWeaknesses.isEmpty {
            filtered = filtered.filter { pokemon in
                let aux = pokemon.pokemonDetails[0].weaknesses!.filter { $0.damageTaken >= 2.0 }
                return selectedWeaknesses.allSatisfy { selectedType in
                    aux.contains { weaks in
                    return weaks.fromType.id == selectedType.type.id
                    }
                }
            }
        }
        return filtered
    }
    @discardableResult
       func filterByWeight() -> [PokemonRaw] {
           if  selectedWeight[0] == true {
               filtered = filtered.filter({ $0.pokemonDetails[0].weight  > ConstantVariables.inicialWeight
                && $0.pokemonDetails[0].weight < ConstantVariables.LowWeight })
           }
           if  selectedWeight[1] == true {
               filtered = filtered.filter({ $0.pokemonDetails[0].weight  > ConstantVariables.LowWeight
                && $0.pokemonDetails[0].weight < ConstantVariables.HeavyWeight })
           }
           if  selectedWeight[2] == true {
               filtered = filtered.filter({ $0.pokemonDetails[0].weight  > ConstantVariables.HeavyWeight })
           }
           return filtered
       }
}
