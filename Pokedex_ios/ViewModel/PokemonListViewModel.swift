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
    var pokemonsCellViewModels = [UITableViewCell]() {
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
                self.fetchData(pokemons: pokemons)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(pokemons: [PokemonRaw]) {
        self.pokemons = pokemons
        var vms = [UITableViewCell]()
        for pokemon in pokemons {
            vms.append(createCellModel(pokemon: pokemon))
        }
        pokemonsCellViewModels = vms
    }
    
    private func createCellModel(pokemon: PokemonRaw) -> UITableViewCell {
        let title = pokemon.name
        let description = pokemon.url
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "PokeCell")
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = description
        
        return cell
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> UITableViewCell {
        return pokemonsCellViewModels[indexPath.row]
    }
    
}
