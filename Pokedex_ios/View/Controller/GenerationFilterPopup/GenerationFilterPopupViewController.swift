//
//  GenerationFilterPopupViewController.swift
//  Pokedex_ios
//
//  Created by admin on 7/12/22.
//

import UIKit

protocol GenerationFilterPopUpDelegate {
    func applyFilter(filtered: [PokemonRaw]) -> Void
}

class GenerationFilterPopupViewController: PopupViewController {
    
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var generationCollectionView: UICollectionView!

    // var viewmodel: GenerationFilterPopupViewModel
    var delegate: GenerationFilterPopUpDelegate?
    let cellIdentifier = "PokemonGenerationCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setUpContent()
        setUpElements()
    }
    
    func initViewModel() {
        GenerationFilterPopupViewModel.shared.closePopup = {[weak self] in
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

        let index = GenerationFilterPopupViewModel.shared.selectedGeneration.firstIndex(where: { $0.name == pokemonGeneration.name })
        cell.setUpData(generation: pokemonGeneration, isTypeSelected: index != nil)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 129)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemonGeneration = ConstantVariables.pokemonGenerations[indexPath.row]
        if let index = GenerationFilterPopupViewModel.shared.selectedGeneration.firstIndex(where: { $0.name == pokemonGeneration.name }) {
            GenerationFilterPopupViewModel.shared.selectedGeneration.remove(at: index)
            GenerationFilterPopupViewModel.shared.resetFilter()
        } else {
            GenerationFilterPopupViewModel.shared.selectedGeneration.append(pokemonGeneration)
            GenerationFilterPopupViewModel.shared.applyFilter()
            self.delegate?.applyFilter(filtered: GenerationFilterPopupViewModel.shared.filtered)
        }
       generationCollectionView.reloadItems(at: [indexPath])
    }
}
