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
        DispatchQueue.main.async {
            self.backgroundUIView.layer.cornerRadius = self.backgroundUIView.frame.size.width/2
            self.backgroundUIView.layer.masksToBounds = true
            self.backgroundUIView.clipsToBounds = true
        }
    }

    func setupData(pokemonType: TypeElement, isTypeSelected: Bool) {
        pokemonTypeImageView.image = UIImage(named: pokemonType.type.name)?.withRenderingMode(.alwaysTemplate)
        let namedColor = UIColor(named: "type-\(pokemonType.type.name)")
        backgroundUIView.backgroundColor = isTypeSelected ? namedColor : .white
        pokemonTypeImageView.tintColor = isTypeSelected ? .white : namedColor
    }
}
