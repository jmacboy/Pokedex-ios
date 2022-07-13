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

    // Collection Views
    @IBOutlet weak var typesCollectionView: UICollectionView!
    var selectedTypesForTypes = [TypeElement]()

    @IBOutlet weak var weaknessesCollectionView: UICollectionView!
    var selectedTypesForWeakness = [TypeElement]()
    @IBOutlet weak var weightCollectionView: UICollectionView!

    var viewmodel: AdvancedFilterPopupViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setupContent()
        setupElements()
    }

    func initViewModel() {
        viewmodel?.closePopup = {[weak self] in
            self?.animateDismissView()
        }
    }

    func setupElements() {
        let uiNibPokemonTypeCell = UINib(nibName: PokemonTypeCollectionCell.nibName, bundle: nil)
        // For Types collection view
        typesCollectionView.register(uiNibPokemonTypeCell, forCellWithReuseIdentifier: PokemonTypeCollectionCell.identifier)
        typesCollectionView.delegate = self
        typesCollectionView.dataSource = self
        // For Weaknesses collection view
        weaknessesCollectionView.register(uiNibPokemonTypeCell, forCellWithReuseIdentifier: PokemonTypeCollectionCell.identifier)
        weaknessesCollectionView.delegate = self
        weaknessesCollectionView.dataSource = self
        // For weight collection view
        let uiNibPokemonWeightCell = UINib(nibName: PokemonWeightCollectionCell.nibName, bundle: nil)
        weightCollectionView.register(uiNibPokemonWeightCell, forCellWithReuseIdentifier: PokemonWeightCollectionCell.identifier)
        weightCollectionView.delegate = self
        weightCollectionView.dataSource = self
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
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40)
        ])
    }

    @IBAction func applyFilters(_ sender: Any) {
        viewmodel?.applyFilters()
    }
    @IBAction func resetFilters(_ sender: Any) {
        viewmodel?.resetFilters()
        typesCollectionView.reloadData()
        weaknessesCollectionView.reloadData()
        weightCollectionView.reloadData()
    }
}

extension AdvancedFilterPopupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.weightCollectionView {
            return ConstantVariables.pokemonWeight.count
        } else {
            return ConstantVariables.pokemonTypes.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pokemonType = ConstantVariables.pokemonTypes[indexPath.row]

        if collectionView == self.weaknessesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonTypeCollectionCell.identifier, for: indexPath)
                    as? PokemonTypeCollectionCell else { return UICollectionViewCell() }
            let index = viewmodel?.selectedWeaknesses.firstIndex(where: { $0.type.id == pokemonType.type.id })
            cell.setupData(pokemonType: pokemonType, isTypeSelected: index != nil)
            return cell
        }
        if collectionView == self.typesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonTypeCollectionCell.identifier, for: indexPath)
                    as? PokemonTypeCollectionCell else { return UICollectionViewCell() }
            let index = viewmodel?.selectedTypesForTypes.firstIndex(where: { $0.type.id == pokemonType.type.id })
            cell.setupData(pokemonType: pokemonType, isTypeSelected: index != nil)
            return cell
        }
        if collectionView == self.weightCollectionView {
            let pokemonWeight = ConstantVariables.pokemonWeight[indexPath.row]
            let index = viewmodel?.selectedWeigth[indexPath.row] ?? false
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonWeightCollectionCell.identifier, for: indexPath)
                    as? PokemonWeightCollectionCell else { return UICollectionViewCell() }
            cell.setupData(pokemonType: pokemonWeight, isTypeSelected: index)
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemonType = ConstantVariables.pokemonTypes[indexPath.row]
        if collectionView == self.weaknessesCollectionView {
             if let index = viewmodel?.selectedWeaknesses.firstIndex(where: { $0.type.id == pokemonType.type.id }) {
                viewmodel?.selectedWeaknesses.remove(at: index)
             } else {
                viewmodel?.selectedWeaknesses.append(pokemonType)
             }
            weaknessesCollectionView.reloadItems(at: [indexPath])
        }
        if collectionView == self.typesCollectionView {
            if let index = viewmodel?.selectedTypesForTypes.firstIndex(where: { $0.type.id == pokemonType.type.id }) {
                viewmodel?.selectedTypesForTypes.remove(at: index)
            } else {
                viewmodel?.selectedTypesForTypes.append(pokemonType)
            }
            typesCollectionView.reloadItems(at: [indexPath])
        }
        if collectionView == self.weightCollectionView {
            if viewmodel?.selectedWeigth[indexPath.row] == true {
                viewmodel?.selectedWeigth[indexPath.row] = false
            } else {
                viewmodel?.selectedWeigth[indexPath.row] = true
            }
            weightCollectionView.reloadItems(at: [indexPath])
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 6.7
        let height = width
        return CGSize(width: width, height: height)
    }

}
