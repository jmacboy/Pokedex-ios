//
//  PokemonHeightCollectionViewCell.swift
//  Pokedex_ios
//
//  Created by user on 18/7/22.
//

import UIKit

class PokemonHeightCollectionViewCell: UICollectionViewCell {

    static let identifier = "PokemonHeightCollectionViewCell"

    @IBOutlet var backgroundUIView: UIView!
    @IBOutlet var pokemonHeightImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.backgroundUIView.layer.cornerRadius = self.backgroundUIView.frame.size.width/2
            self.backgroundUIView.layer.masksToBounds = true
            self.backgroundUIView.clipsToBounds = true
        }
    }

    func setupData(pokemonHeight: PokemonHeigths, isHeightSelected: Bool) {
        pokemonHeightImageView.image = UIImage(named: pokemonHeight.rawValue)?.withRenderingMode(.alwaysTemplate)
        let namedColor = UIColor(named: "height-\(pokemonHeight.rawValue)")
        backgroundUIView.backgroundColor = isHeightSelected ? namedColor : .white
        pokemonHeightImageView.tintColor = isHeightSelected ? .white : namedColor
    }

}
