//
//  ViewController.swift
//  Pokedex_ios
//
//  Created by admin on 6/29/22.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var pokemonsTableView: UITableView!
    
    let pokemonCell = "PokemonTableViewCell"
    let pokeCellIdentifier = "PokeCell"
    
    lazy var viewModel = {
        PokemonListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonsTableView.delegate = self
        pokemonsTableView.dataSource = self
        setBackground()
        initViewModel()
        
        let uiNib = UINib(nibName: pokemonCell, bundle: nil)
        pokemonsTableView.register(uiNib, forCellReuseIdentifier: pokeCellIdentifier)
    }
    
    private func setBackground() {
        let margins = view.layoutMarginsGuide
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: ConstantVariables.pokeImageHeader)
        imageView.alpha = 0.03
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: margins.topAnchor, constant: -300).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 1).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, constant: 1).isActive = true
        
        self.view.sendSubviewToBack(imageView)
    }
    
    func initViewModel() {
        viewModel.getPokemons()
        
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.pokemonsTableView.reloadData()
            }
        }
        
        viewModel.showErrorAlert = {
            let sheet = UIAlertController(title: "Something went wrong", message: "Can't show pokemons right now, please try again later", preferredStyle: .alert)
            sheet.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.navigationController?.present(sheet, animated: true, completion: nil)
        }
    }
}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pokeCellIdentifier, for: indexPath) as? PokemonTableViewCell ?? PokemonTableViewCell()
        
        let cellData = viewModel.getCellData(at: indexPath)
        cell.setUpPokemonData(pokemon: cellData)
//        print(cellData)
        
        return cell
    }
}

