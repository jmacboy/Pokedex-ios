//
//  ViewController.swift
//  Pokedex_ios
//
//  Created by admin on 6/29/22.
//

import UIKit

class PokemonListViewController: UIViewController {
    @IBOutlet weak var pokemonsTableView: UITableView!
    @IBOutlet weak var pokemonSearchTextField: UITextField!
    @IBOutlet weak var searchView: UIView!

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
        setSearchView()
        // Setup for all filter image and button
        setFiltersIconsPopup()
        // Register the custom cell
        setSearchView()
        let uiNib = UINib(nibName: pokemonCell, bundle: nil)
        pokemonsTableView.register(uiNib, forCellReuseIdentifier: pokeCellIdentifier)
    }
    func setFiltersIconsPopup() {
        let advancedFilterImage = UIImage(named: "AdvancedFilterSVG")?.withRenderingMode(.alwaysOriginal)
        let advancedFilterButton = UIBarButtonItem(image: advancedFilterImage, style: .plain,
                                                   target: self, action: #selector(showAdvancedFilterPopup))

        let generationFilterImage = UIImage(named: "generationFilterIcon")?.withRenderingMode(.alwaysOriginal)
        let generationFilterButton = UIBarButtonItem(image: generationFilterImage, style: .plain,
                                                   target: self, action: #selector(showGenerationFilterPopup))

        let sortFilterImage = UIImage(named: "sortIcon")?.withRenderingMode(.alwaysOriginal)
        let sortFilterButton = UIBarButtonItem(image: sortFilterImage, style: .plain,
                                                   target: self, action: #selector(showSortFilterPopup))

        navigationItem.rightBarButtonItems = [advancedFilterButton, sortFilterButton, generationFilterButton]
    }

    @objc func showAdvancedFilterPopup() {
        let vc = AdvancedFilterPopupViewController()
        vc.viewmodel = viewModel.filterViewModel
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    @objc func showGenerationFilterPopup() {
        let vc = GenerationFilterPopupViewController()
        vc.viewmodel = viewModel.filterGenerationViewModel
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    @objc func showSortFilterPopup() {
        let sortPokemonListViewModel = SortPokemonListViewModel(pokemons: viewModel.pokemons)
        sortPokemonListViewModel.sortButtonActionDelegateDelegate = viewModel.self
        let vc = SortFilterViewController(sortPokemonListViewModel: sortPokemonListViewModel)
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
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
            let sheet = UIAlertController(title: "Something went wrong", message: "Can't show pokemons right now, please try again later",
            preferredStyle: .alert)
            sheet.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.navigationController?.present(sheet, animated: true, completion: nil)
        }
    }

    func setSearchView() {
        pokemonSearchTextField.addTarget(self, action: #selector(PokemonListViewController.textFieldDidChange(_:)), for: .editingChanged)
        searchView.layer.cornerRadius = 10
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        viewModel.searchText = text
        viewModel.applyFilters()
    }
}

extension PokemonListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: pokeCellIdentifier, for: indexPath) as? PokemonTableViewCell
        ?? PokemonTableViewCell()

        let cellData = viewModel.getCellData(at: indexPath)
        cell.setUpPokemonData(pokemon: cellData)
        cell.selectionStyle = .none

      return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var stats = [Stats]()
        let cellData = viewModel.getCellData(at: indexPath)
        guard let weaknesses = cellData.pokemonDetails[0].weaknesses else { return }
        viewModel.getPokemonStats(pokemondId: cellData.id) {
            stats = self.viewModel.stats
            let vc = TypeDefensesViewController(stats: stats, weaknesses: weaknesses, forType: cellData.pokemonDetails[0].types[0].type.name)
            self.show(vc, sender: nil)
        }
    }
}
