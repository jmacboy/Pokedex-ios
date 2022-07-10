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
    @IBOutlet weak var weaknessesCollectionView: UICollectionView!

    var selectedTypesForWeakness = [TypeElement]()
    var selectedTypesForTypes = [TypeElement]()

    lazy var viewmodel = {
        AdvancedFilterPopupViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setupContent()
        setupElements()
    }

    func initViewModel() {
        viewmodel.closePopup = {[weak self] in
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
//            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40)
        ])
    }

    @IBAction func applyFilters(_ sender: Any) {
        viewmodel.applyFilters()
    }
    @IBAction func resetFilters(_ sender: Any) {
        viewmodel.resetFilters()
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

        if collectionView == self.weaknessesCollectionView {
            let index = selectedTypesForWeakness.firstIndex(where: { $0.type.id == pokemonType.type.id })
            cell.setupData(pokemonType: pokemonType, isTypeSelected: index != nil)
        }
        if collectionView == self.typesCollectionView {
            let index = selectedTypesForTypes.firstIndex(where: { $0.type.id == pokemonType.type.id })
            cell.setupData(pokemonType: pokemonType, isTypeSelected: index != nil)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemonType = ConstantVariables.pokemonTypes[indexPath.row]
        if collectionView == self.weaknessesCollectionView {
            if let index = selectedTypesForWeakness.firstIndex(where: { $0.type.id == pokemonType.type.id }) {
                selectedTypesForWeakness.remove(at: index)
            } else {
                selectedTypesForWeakness.append(pokemonType)
            }
            weaknessesCollectionView.reloadItems(at: [indexPath])
        }
        if collectionView == self.typesCollectionView {
            if let index = selectedTypesForTypes.firstIndex(where: { $0.type.id == pokemonType.type.id }) {
                selectedTypesForTypes.remove(at: index)
            } else {
                selectedTypesForTypes.append(pokemonType)
            }
            typesCollectionView.reloadItems(at: [indexPath])
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 6.7
        let height = width
        return CGSize(width: width, height: height)
    }
}
