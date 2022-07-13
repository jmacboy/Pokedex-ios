//
//  PokemonWeightCollectionCell.swift
//  Pokedex_ios
//
//  Created by Irving Villanueva on 7/13/22.
//
import UIKit

class PokemonWeightCollectionCell: UICollectionViewCell {
    static let nibName = "PokemonWeightCollectionCell"
    static let identifier = "PokemonWeightCollectionCell"
    @IBOutlet weak var backgroundUIView: UIView!
    @IBOutlet weak var pokemonWeightImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.backgroundUIView.layer.cornerRadius = self.backgroundUIView.frame.size.width/2
            self.backgroundUIView.layer.masksToBounds = true
            self.backgroundUIView.clipsToBounds = true
        }
    }
    func setupData(pokemonType: String, isTypeSelected: Bool) {
        pokemonWeightImageView.image = UIImage(named: pokemonType)?.withRenderingMode(.alwaysTemplate)
        let namedColor = UIColor(named: "type-\(pokemonType)")
        backgroundUIView.backgroundColor = isTypeSelected ? namedColor : .white
        pokemonWeightImageView.tintColor = isTypeSelected ? .white : namedColor
    }

}
