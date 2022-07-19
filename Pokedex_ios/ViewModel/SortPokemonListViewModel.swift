//
//  SortPokemonListViewModel.swift
//  Pokedex_ios
//
//  Created by admin on 7/15/22.
//

import UIKit
import Foundation

class SortPokemonListViewModel {

    var pokemons: [PokemonRaw]
    weak var sortButtonActionDelegateDelegate: SortButtonActionDelegateDelegate?

    init(pokemons: [PokemonRaw]) {
        self.pokemons = pokemons
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
