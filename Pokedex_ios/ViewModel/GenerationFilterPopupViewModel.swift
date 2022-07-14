//
//  GenerationFilterPopupViewModel.swift
//  Pokedex_ios
//
//  Created by admin on 7/13/22.
//

import Foundation

struct GenerationAux {
    let name: String
    let description: String
}

class GenerationFilterPopupViewModel {

    static let shared = GenerationFilterPopupViewModel()

    var filtered = [PokemonRaw]()
    var selectedGeneration = [GenerationAux]()
    var pokemons = [PokemonRaw]()

    var delegate: ReevaluateDataProtocol?
    var closePopup: (() -> Void)?

    func applyFilter() {
        closePopup?()
        filterByGeneration()
        delegate?.reevaluate(pokemons: filtered)
    }

    func resetFilter() {
        selectedGeneration.removeAll()
        filtered.removeAll()
    }

    @discardableResult
    func filterByGeneration() -> [PokemonRaw] {
        filtered = pokemons
        if selectedGeneration.isEmpty {
            return pokemons
        }

        filtered = pokemons.filter({ pokemon in
            return pokemon.generation.name == selectedGeneration.first?.description.lowercased()
        })
        print(filtered.count)
        return filtered
    }
}
