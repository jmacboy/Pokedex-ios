//
//  GenerationFilterPopupViewModel.swift
//  Pokedex_ios
//
//  Created by admin on 7/13/22.
//

import Foundation

protocol ReevaluateDataProtocolGeneration: AnyObject {
    func reevaluateGeneration(pokemons: [PokemonRaw])
    func devaluateGeneration(pokemons: [PokemonRaw])
}

struct GenerationAux {
    let name: String
    let description: String
}

class GenerationFilterPopupViewModel {

    var filtered = [PokemonRaw]()
    var selectedGeneration = [GenerationAux]()
    var pokemons = [PokemonRaw]()

    var delegate: ReevaluateDataProtocolGeneration?
    var closePopup: (() -> Void)?

    func applyFilter() {
        closePopup?()
        filterByGeneration()
        delegate?.reevaluateGeneration(pokemons: filtered)
    }

    func resetFilter() {
        closePopup?()
        selectedGeneration.removeAll()
        delegate?.devaluateGeneration(pokemons: pokemons)
    }

    @discardableResult
    func filterByGeneration() -> [PokemonRaw] {
        if selectedGeneration.isEmpty {
            filtered = pokemons
            return pokemons
        }

        filtered = pokemons.filter({ pokemon in
            return pokemon.generation.name == selectedGeneration.first?.description.lowercased()
        })

        return filtered
    }
}
