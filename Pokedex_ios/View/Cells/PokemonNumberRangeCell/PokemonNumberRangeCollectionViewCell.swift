//
//  PokemonNumberRangeCollectionViewCell.swift
//  Pokedex_ios
//
//  Created by user on 19/7/22.
//

import UIKit

class PokemonNumberRangeCollectionViewCell: UICollectionViewCell {
    static let identifier = "PokemonNumberRangeCollectionViewCell"

    let rangeSlider = RangeSlider()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupRageSlider()
    }

    func setupRageSlider() {
        rangeSlider.upperValue = 898
        rangeSlider.lowerValue = 1
        rangeSlider.lowerValue = 78.0
        rangeSlider.upperValue = 687.0
        contentView.addSubview(rangeSlider)
        let margin: CGFloat = 20.0
        let width = contentView.bounds.width - 1.0 * margin
        rangeSlider.frame = CGRect(x: margin, y: margin, width: width, height: 25.0)
    }
}
