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
    var selectedWeight: [Bool] = Array(repeating: false, count: 3)
    var selectedHeights = [PokemonHeigths]()
    var selectedRangeLimits = [
        ConstantVariables.rangeValuesLowerUpper[0],
        ConstantVariables.rangeValuesLowerUpper[1]
    ]
    func applyFilters() {
        closePopup?()
        // Do not rearrange the following filters functions
        filterByTypes()
        filterByWeaknesses()
        filterByWeight()
        filterByHeights()
        filterByNumberRange()
        delegate?.reevaluate(pokemons: filtered)
    }

    func resetFilters() {
        // Make all the logic for reset the filters
        selectedTypesForTypes.removeAll()
        selectedWeaknesses.removeAll()
        selectedWeight = Array(repeating: false, count: selectedWeight.count)
        selectedHeights.removeAll()
        selectedRangeLimits = [
            ConstantVariables.rangeValuesLowerUpper[0],
            ConstantVariables.rangeValuesLowerUpper[1]
        ]
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
    @discardableResult
    func filterByHeights() -> [PokemonRaw] {
        guard !selectedHeights.isEmpty else { return filtered }
        var pokemonList: [PokemonRaw] = []
        for height in selectedHeights {
           switch height {
           case .small:
               pokemonList += self.filterSmall(pokemons: self.filtered)
           case .medium:
               pokemonList += self.filterMedium(pokemons: self.filtered)
           case .large:
               pokemonList += self.filterLarge(pokemons: self.filtered)
           }
        }
        self.filtered = pokemonList
        return filtered
   }

    @discardableResult
    func filterByNumberRange() -> [PokemonRaw] {
        filtered = filtered.filter({ $0.id >= Int(selectedRangeLimits[0])
            && $0.id <= Int(selectedRangeLimits[1]) })
        return filtered
   }

   private func filterSmall(pokemons: [PokemonRaw]) -> [PokemonRaw] {
       return pokemons.filter({ $0.pokemonDetails[0].height < 13 })
   }

   private func filterMedium(pokemons: [PokemonRaw]) -> [PokemonRaw] {
       return pokemons.filter({ $0.pokemonDetails[0].height >= 13 && $0.pokemonDetails[0].height < 22 })
   }

   private func filterLarge(pokemons: [PokemonRaw]) -> [PokemonRaw] {
       return pokemons.filter({ $0.pokemonDetails[0].height >= 22 })
   }
}
