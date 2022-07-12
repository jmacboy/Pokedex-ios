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

    var pokemonOriginal = [PokemonRaw]()
    var filtered = [PokemonRaw]()
    var selectedWeaknesses = [TypeElement]()

    var delegate: ReevaluateDataProtocol?

    var closePopup: (() -> Void)?
    var pokemons = [PokemonRaw]()
    var selectedTypesForTypes = [TypeElement]()
    var delegate: ReevaluateDataProtocol?

    func applyFilters() {
        filterByWeaknesses()
        closePopup?()
        filterByTypes(pokeData: pokemons)
        delegate?.reevaluate(pokemons: filtered)
    }

    func resetFilters() {
        // Make all the logic for reset the filters
        selectedTypesForTypes.removeAll()
        selectedWeaknesses.removeAll()
    }
    private func checkAllTypes(arr: [TypeElement], target: [TypeElement]) -> Bool {
        target.allSatisfy({ type in
            return arr.contains(where: { tarType in
                tarType == type
            })
        })
    }
    @discardableResult
    func filterByTypes(pokeData: [PokemonRaw]) -> [PokemonRaw] {
        let filteredData = pokeData.filter({pokemon in
            return self.checkAllTypes(arr: pokemon.pokemonDetails[0].types, target: selectedTypesForTypes)
        })
        delegate?.reevaluate(pokemons: filteredData)
        return filteredData
    }

    @discardableResult
    func filterByWeaknesses() -> [PokemonRaw] {
        if selectedWeaknesses.isEmpty {
            filtered = pokemonOriginal
        } else {
            filtered = pokemonOriginal.filter { pokemon in
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
}
