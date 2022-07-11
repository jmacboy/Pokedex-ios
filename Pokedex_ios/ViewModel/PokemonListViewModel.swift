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
    var pokemonsOriginal = [PokemonRaw]()

    var reloadData: (() -> Void)?
    var showErrorAlert: (() -> Void)?

    var pokemonsOriginalList = [PokemonRaw]()
    var pokemons = [PokemonRaw]() {
        didSet {
            reloadData?()
        }
    }
    var searchText = ""

    init(pokedexService: PokedexServiceProtocol = PokedexService()) {
        self.pokedexService = pokedexService
    }

    func getPokemons() {
        pokedexService.getPokemons { result in
            switch result {
            case .success(let pokemons):
                self.pokemonsOriginalList = pokemons
                self.pokemons = pokemons
            case .failure:
                self.showErrorAlert?()
            }
        }
    }

    func applyFilters() {
        pokemons = self.pokemonsOriginalList
        
        self.searchPokemonsByName()
    }

    func searchPokemonsByName() {
        if !self.searchText.isEmpty {
            pokemons = pokemons.filter({
                $0.name.contains(searchText.lowercased())
            })
        }
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

extension PokemonListViewModel: PokemonListViewModelDelegate {
    func filteredPokemonData(filteredPokemons: [PokemonRaw]) {
        self.pokemons = filteredPokemons
    }
}
