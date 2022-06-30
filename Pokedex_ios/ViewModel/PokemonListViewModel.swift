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
    
    var pokemons = [PokemonRaw]()
    
//    var pokemonsCellViewModels = [PokemonTableViewCell]() {
//        didSet {
//            reloadTableView?()
//        }
//    }
    
    init(pokedexService: PokedexServiceProtocol = PokedexService()) {
        self.pokedexService = pokedexService
    }
    
    func getPokemons() {
        pokedexService.getPokemons { success, results, error in
            if success, let pokemons = results {
                self.fetchData(pokemons: pokemons)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(pokemons: [PokemonRaw]) {
        self.pokemons = pokemons
//        var vms = [PokemonTableViewCell]()
//        for pokemon in pokemons {
//            vms.append(createCellModel(pokemon: pokemon))
//        }
//        pokemonsCellViewModels = vms
    }
    
    private func createCellModel(pokemon: PokemonRaw) -> PokemonTableViewCell {
        let cell = PokemonTableViewCell()
        return cell
    }
    
//    func getCellViewModel(at indexPath: IndexPath) -> PokemonTableViewCell {
//        return pokemonsCellViewModels[indexPath.row]
//    }
    
    func getCellData(at indexPath: IndexPath) -> PokemonRaw {
        return pokemons[indexPath.row]
    }
}
