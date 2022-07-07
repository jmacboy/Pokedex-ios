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
        pokedexService.getPokemons { result in
            switch result {
            case .success(let pokemons):
                self.pokemons = pokemons
            case .failure:
                self.showErrorAlert?()
            }
        }
    }
    
    func searchPokemonsByName(searchText: String) {
        pokemons = pokemons.filter({
            $0.name.lowercased().prefix(searchText.count) == searchText.lowercased()
        })
    }
    
    func getCellData(at indexPath: IndexPath, search: Bool) -> PokemonRaw {
        return pokemons[indexPath.row]
    }

    func getCellData(at indexPath: IndexPath) -> PokemonRaw {
        return pokemons[indexPath.row]
    }

    func getPokemonsImageBy(id: Int) -> UIImage? {
        let urlStr = pokedexService.getPokemonsImageBy(id: id)
        let url = URL(string: urlStr)
        let data = try? Data(contentsOf: url!)
        let image = UIImage(data: data!)

        return image
    }
}
