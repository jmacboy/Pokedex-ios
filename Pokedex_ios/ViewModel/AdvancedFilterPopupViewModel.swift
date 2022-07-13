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
    var caterpieSelected: Bool = false
    var laprasSelected: Bool = false
    var snorlaxSelected: Bool = false
    var delegate: ReevaluateDataProtocol?
    var closePopup: (() -> Void)?
    var pokemons = [PokemonRaw]()
    var selectedTypesForTypes = [TypeElement]()

    func applyFilters() {
        closePopup?()
        // Do not rearrange the following filters functions
        filterByTypes()
        filterByWeaknesses()
        filterLowWeigth()
        filterMidWeigth()
        filterHeavyWeigth()
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
       func filterLowWeigth() -> [PokemonRaw] {
           if  caterpieSelected == true {
               filtered = filtered.filter({ $0.pokemonDetails[0].weight  > 0  && $0.pokemonDetails[0].weight < 132 })
           }
           return filtered
       }
       @discardableResult
       func filterMidWeigth() -> [PokemonRaw] {
           if  laprasSelected == true {
               filtered = filtered.filter({ $0.pokemonDetails[0].weight  > 132  && $0.pokemonDetails[0].weight < 451 })
           }
           return filtered
       }
       @discardableResult
       func filterHeavyWeigth() -> [PokemonRaw] {
           if  snorlaxSelected == true {
               filtered = filtered.filter({ $0.pokemonDetails[0].weight  > 451 })
           }
           return filtered
       }
}
