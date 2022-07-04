//
//  PokemonListViewModel.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 29/6/22.
//

import Foundation
import UIKit

class PokemonListViewModel: NSObject {
    var pokedexService: PokedexServiceProtocol
    
    var reloadData: (() -> Void)?
    var showErrorAlert: (() -> Void)?
    
    var pokemons = [PokemonRaw]() {
        didSet {
            reloadData?()
        }
    }
    
    init(pokedexService: PokedexServiceProtocol = PokedexService()) {
        self.pokedexService = pokedexService
    }
    
    func getPokemons() {
        pokedexService.getPokemons { success, results, error in
            if success, let pokemons = results {
                self.pokemons = pokemons
            } else {
                self.showErrorAlert?()
            }
        }
    }
    
    func getCellData(at indexPath: IndexPath) -> PokemonRaw {
        return pokemons[indexPath.row]
    }
}
