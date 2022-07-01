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
        pokedexService.getPokemons { result in
            switch result {
            case.success(let pokemons):
                self.pokemons = pokemons
            case.failure(let error):
                print("Error: ", error)
            }

        }
    }
    
    func getCellData(at indexPath: IndexPath) -> PokemonRaw {
        return pokemons[indexPath.row]
    }
}
