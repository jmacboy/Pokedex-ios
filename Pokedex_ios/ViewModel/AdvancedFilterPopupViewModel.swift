//
//  AdvancedFilterPopupViewModel.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 5/7/22.
//

import Foundation

protocol PokemonListViewModelDelegate {
    func filteredPokemonData(filteredPokemons: [PokemonRaw])
}

class AdvancedFilterPopupViewModel {

    var pokemonOriginal: [PokemonRaw]
    var filtered = [PokemonRaw]()

    var delegate: PokemonListViewModelDelegate?

    init(pokemons: [PokemonRaw]) {
        self.pokemonOriginal = pokemons
    }

    var closePopup: (() -> Void)?

    func applyFilters(weaknesses: [TypeElement]) {
        filterByWeaknesses(weaknesses)
        self.delegate?.filteredPokemonData(filteredPokemons: filtered)
        closePopup?()
    }

    func resetFilters() {
        // TODO: Make all the logic for reset the filters
    }

    func filterByWeaknesses(_ weaknessesTypes: [TypeElement]) {
        filtered = pokemonOriginal.filter { $0.pokemonDetails[0].weaknesses!.contains { weakness in
            let aux = weaknessesTypes.contains { $0.type.id == weakness.fromType.id }
            return weakness.damageTaken == 2.0 && aux
        }}

    }
}
