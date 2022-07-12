//
//  AdvancedFilterPopupViewModel.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 5/7/22.
//

import Foundation

protocol PokemonListViewModelProtocol: AnyObject {
    func reevaluatePokemonData(filteredPokemons: [PokemonRaw])
}

class AdvancedFilterPopupViewModel {

    var pokemonOriginal = [PokemonRaw]()
    var filtered = [PokemonRaw]()
    var selectedWeaknesses = [TypeElement]()

    var delegate: PokemonListViewModelProtocol?

    var closePopup: (() -> Void)?

    func applyFilters() {
        filterByWeaknesses()
        self.delegate?.reevaluatePokemonData(filteredPokemons: filtered)
        closePopup?()
    }

    func resetFilters() {
        selectedWeaknesses.removeAll()
    }

    func filterByWeaknesses() {
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

    }
}
