//
//  GenerationFilterPopupViewController.swift
//  Pokedex_ios
//
//  Created by admin on 7/12/22.
//

import UIKit

class GenerationFilterPopupViewController: PopupViewController {

    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var generationCollectionView: UICollectionView!

    var viewmodel: GenerationFilterPopupViewModel?
    let cellIdentifier = "PokemonGenerationCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setUpContent()
        setUpElements()
    }

    func initViewModel() {
        viewmodel?.closePopup = {[weak self] in
            self?.animateDismissView()
        }
    }

    func setUpContent() {
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

    func setUpElements() {
        self.generationCollectionView.delegate = self
        self.generationCollectionView.dataSource = self

        let uiNibPokemonGenerationCell = UINib(nibName: "GenerationCollectionViewCell", bundle: nil)
        self.generationCollectionView.register(uiNibPokemonGenerationCell, forCellWithReuseIdentifier: cellIdentifier)
    }

}

extension GenerationFilterPopupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ConstantVariables.pokemonGenerations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pokemonGeneration = ConstantVariables.pokemonGenerations[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
                as? GenerationCollectionViewCell ?? GenerationCollectionViewCell()

        let index = viewmodel?.selectedGeneration.firstIndex(where: { $0.name == pokemonGeneration.name })
        cell.setUpData(generation: pokemonGeneration, isTypeSelected: index != nil)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 129)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemonGeneration = ConstantVariables.pokemonGenerations[indexPath.row]
        if let index = viewmodel?.selectedGeneration.firstIndex(where: { $0.name == pokemonGeneration.name }) {
            viewmodel?.selectedGeneration.remove(at: index)
            viewmodel?.resetFilter()
        } else {
            if let selected = viewmodel?.selectedGeneration.isEmpty, selected {
                viewmodel?.selectedGeneration.append(pokemonGeneration)
                viewmodel?.applyFilter()
            }
        }
       generationCollectionView.reloadItems(at: [indexPath])
    }
}
