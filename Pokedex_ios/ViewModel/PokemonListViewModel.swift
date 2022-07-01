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
    
    var reloadTableView: (() -> Void)?
    
    var pokemons = [PokemonRaw]() {
        didSet {
            reloadTableView?()
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
                print(error!)
            }
        }
    }
    
    func getCellData(at indexPath: IndexPath) -> PokemonRaw {
        return pokemons[indexPath.row]
    }
}
