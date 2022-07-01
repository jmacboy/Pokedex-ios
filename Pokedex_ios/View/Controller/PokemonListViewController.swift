//
//  ViewController.swift
//  Pokedex_ios
//
//  Created by admin on 6/29/22.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel = {
        PokemonListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setBackground()
        initViewModel()
        
        let uiNib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
        tableView.register(uiNib, forCellReuseIdentifier: "PokeCell")
    }
    
    private func setBackground() {
        let margins = view.layoutMarginsGuide
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PokeballSVG")
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
        print(viewModel.pokemons)
        
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath) as? PokemonTableViewCell ?? PokemonTableViewCell()
        
        let cellData = viewModel.getCellData(at: indexPath)
        cell.setUpPokemonData(pokemon: cellData)
        
        return cell
    }
}

