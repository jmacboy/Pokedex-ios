//
//  PokemonTypeCollectionCell.swift
//  Pokedex_ios
//
//  Created by Yawar Valeriano on 7/7/22.
//

import UIKit

class PokemonTypeCollectionCell: UICollectionViewCell {
    static let nibName = "PokemonTypeCollectionCell"
    static let identifier = "PokemonTypeCollectionCell"

    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var pokemonTypeImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundUIView.layer.cornerRadius = backgroundUIView.layer.bounds.width / 2
        backgroundUIView.clipsToBounds = true
//        backgroundUIView.layer.borderColor = UIColor.darkGray.cgColor
//        backgroundUIView.layer.borderWidth = 2.0
    }

    func setupData(pokemonType: TypeElement, isTypeSelected: Bool) {
        pokemonTypeImageView.image = UIImage(named: pokemonType.type.name)
        let namedColor = UIColor(named: "type-\(pokemonType.type.name)")
        backgroundUIView.backgroundColor = isTypeSelected ? namedColor : .white
        pokemonTypeImageView.tintColor = isTypeSelected ? .white : namedColor
    }

}
