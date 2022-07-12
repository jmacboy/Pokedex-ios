//
//  AdvancedFilterPopupViewController.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 7/7/22.
//

import UIKit

class AdvancedFilterPopupViewController: PopupViewController {
    @IBOutlet weak var contentStackView: UIStackView!

    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var weaknessesCollectionView: UICollectionView!

    var selectedTypesForWeakness = [TypeElement]()

    var viewModel: AdvancedFilterPopupViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setupContent()
        setupElements()
    }

    func initViewModel() {
        viewModel?.closePopup = {[weak self] in
            self?.animateDismissView()
        }
    }

    func setupElements() {
        let uiNibPokemonTypeCell = UINib(nibName: PokemonTypeCollectionCell.nibName, bundle: nil)
        weaknessesCollectionView.register(uiNibPokemonTypeCell, forCellWithReuseIdentifier: PokemonTypeCollectionCell.identifier)
        weaknessesCollectionView.delegate = self
        weaknessesCollectionView.dataSource = self
    }

    func setupContent() {
        applyButton.layer.cornerRadius = 10
        resetButton.layer.cornerRadius = 10
        let spacer = UIView()
        contentStackView.addArrangedSubview(spacer)
        containerView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40)
        ])
    }

    @IBAction func applyFilters(_ sender: Any) {
        viewModel?.applyFilters()
    }
    @IBAction func resetFilters(_ sender: Any) {
        viewModel?.resetFilters()
        weaknessesCollectionView.reloadData()
    }
}

extension AdvancedFilterPopupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ConstantVariables.pokemonTypes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pokemonType = ConstantVariables.pokemonTypes[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonTypeCollectionCell.identifier, for: indexPath)
                as? PokemonTypeCollectionCell else { return UICollectionViewCell() }

        let index = viewModel?.selectedWeaknesses.firstIndex(where: { $0.type.id == pokemonType.type.id })
        cell.setupData(pokemonType: pokemonType, isTypeSelected: index != nil)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemonType = ConstantVariables.pokemonTypes[indexPath.row]

        if let index = viewModel?.selectedWeaknesses.firstIndex(where: { $0.type.id == pokemonType.type.id }) {
            viewModel?.selectedWeaknesses.remove(at: index)
        } else {
            viewModel?.selectedWeaknesses.append(pokemonType)
        }
        weaknessesCollectionView.reloadItems(at: [indexPath])
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 6.7
        let height = width
        return CGSize(width: width, height: height)
    }

}
