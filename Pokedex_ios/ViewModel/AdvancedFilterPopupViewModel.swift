//
//  AdvancedFilterPopupViewModel.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 5/7/22.
//

import Foundation

protocol ReevaluateDataProtocol {
    func reevaluate(pokemons: [PokemonRaw])
}

class AdvancedFilterPopupViewModel {
    var closePopup: (() -> Void)?
    var pokemons = [PokemonRaw]()
    var selectedTypesForTypes = [TypeElement]()
    var delegate: ReevaluateDataProtocol?
    @objc func applyFilters() {
        // Make all the filter logic here
        closePopup?()
        self.filterByTypes(pokeData: self.pokemons)
    }
    func resetFilters() {
        // Make all the logic for reset the filters
        selectedTypesForTypes.removeAll()
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
}
