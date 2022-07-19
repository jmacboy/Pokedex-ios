//
//  SortPokemonListViewModel.swift
//  Pokedex_ios
//
//  Created by adri on 7/15/22.
//

import UIKit
import Foundation

class SortPokemonListViewModel {

    var pokemons: [PokemonRaw]
    weak var sortButtonActionDelegateDelegate: SortButtonActionDelegateDelegate?

    init(pokemons: [PokemonRaw]) {
        self.pokemons = pokemons
    }

    var closePopup: (() -> Void)?
        @objc func applyFilters() {
            closePopup?()
        }
    // MARK: Sorting Logic
    func sortWithSmallestNumberFirst() {
        pokemons = pokemons.sorted(by: { pokemanRow1, pokemanRow2 in
            return pokemanRow1.id < pokemanRow2.id
        })
        sortButtonActionDelegateDelegate?.sortButtonAction(pokemons: pokemons)
    }
    func sortWithHighestNumberFirst() {
        pokemons = pokemons.sorted(by: { pokemanRow1, pokemanRow2 in
            return pokemanRow1.id > pokemanRow2.id
        })
        sortButtonActionDelegateDelegate?.sortButtonAction(pokemons: pokemons)
    }
    func sortWithAtoZ() {
        pokemons = pokemons.sorted(by: { pokemanRow1, pokemanRow2 in
            return pokemanRow1.name < pokemanRow2.name
        })
        sortButtonActionDelegateDelegate?.sortButtonAction(pokemons: pokemons)
    }
    func sortWithZtoA() {
        pokemons = pokemons.sorted(by: { pokemanRow1, pokemanRow2 in
            return pokemanRow1.name > pokemanRow2.name
        })
        sortButtonActionDelegateDelegate?.sortButtonAction(pokemons: pokemons)
    }
}
