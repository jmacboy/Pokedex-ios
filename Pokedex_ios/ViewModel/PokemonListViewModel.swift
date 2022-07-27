//
//  PokemonListViewModel.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 29/6/22.
//

import Foundation
import UIKit

class PokemonListViewModel: NSObject {

    static let shared = PokemonListViewModel()
    var pokedexService: PokedexServiceProtocol

    var reloadData: (() -> Void)?
    var showErrorAlert: (() -> Void)?
    var filterViewModel = AdvancedFilterPopupViewModel() {
        didSet {
            filterViewModel.delegate = self
        }
    }
    var filterGenerationViewModel = GenerationFilterPopupViewModel() {
        didSet {
            filterGenerationViewModel.delegate = self
        }
    }

    var pokemonsOriginalList = [PokemonRaw]()
    var pokemons = [PokemonRaw]() {
        didSet {
            reloadData?()
        }
    }
    var searchText = ""
    var stats = [Stats]()

    init(filterVM: AdvancedFilterPopupViewModel = AdvancedFilterPopupViewModel(), pokedexService: PokedexServiceProtocol = PokedexService(), filterG: GenerationFilterPopupViewModel = GenerationFilterPopupViewModel()) {
        self.pokedexService = pokedexService
        defer {
            self.filterViewModel = filterVM
            self.filterGenerationViewModel = filterG
        }
        super.init()
    }

    func getPokemons() {
        pokedexService.getPokemons { result in
            switch result {
            case .success(let pokemons):
                self.pokemonsOriginalList = pokemons
                self.pokemons = pokemons
                self.filterViewModel.pokemons = pokemons
                self.filterGenerationViewModel.pokemons = pokemons
            case .failure:
                self.showErrorAlert?()
            }
        }
    }

    func getPokemonStats(pokemondId: Int, completion: ( () -> Void )?) {
        pokedexService.getPokemonStat(pokemonId: pokemondId) { result in
            switch result {
            case .success(let stats):
                self.stats = stats.stats
                completion?()
            case .failure(let error):
                print(error)
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
        guard let dataValue = data else {return UIImage(named: "questionIcon")}
        let image = UIImage(data: dataValue)

        return image
    }
}

extension PokemonListViewModel: ReevaluateDataProtocol {
    func reevaluate(pokemons: [PokemonRaw]) {
        self.pokemons = pokemons
    }
}

extension PokemonListViewModel: ReevaluateDataProtocolGeneration {
    func reevaluateGeneration(pokemons: [PokemonRaw]) {
        self.pokemons = pokemons
    }

    func devaluateGeneration(pokemons: [PokemonRaw]) {
        self.pokemons = pokemons
    }
}

extension PokemonListViewModel: SortButtonActionDelegateDelegate {
    func sortButtonAction(pokemons: [PokemonRaw]) {
        self.pokemons = pokemons
    }
}
