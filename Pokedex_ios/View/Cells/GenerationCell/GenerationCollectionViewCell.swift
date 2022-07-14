//
//  GenerationCollectionViewCell.swift
//  Pokedex_ios
//
//  Created by admin on 7/12/22.
//

import UIKit

class GenerationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var generationImageView: UIImageView!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var generationBackground: UIView!
    @IBOutlet weak var patternImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpData(generation: GenerationAux, isTypeSelected: Bool) {
        generationLabel.text = generation.name
        let imageName = "pokemon-\(generation.description)"
        generationImageView.image = UIImage(named: imageName)

        if isTypeSelected {
            generationLabel.textColor = UIColor(named: "TextWhiteColor")
            patternImageView.backgroundColor = UIColor(named: "background-generation-selected")
            generationBackground.backgroundColor = UIColor(named: "background-generation-selected")
            generationImageView.tintColor = UIColor(named: "background-generation-selected")
        }
    }
}
