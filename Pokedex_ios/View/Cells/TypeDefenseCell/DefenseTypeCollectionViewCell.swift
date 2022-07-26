//
//  DefenseTypeCollectionViewCell.swift
//  Pokedex_ios
//
//  Created by Yawar Valeriano on 7/22/22.
//

import UIKit

class DefenseTypeCollectionViewCell: UICollectionViewCell {

    static let identifier = "DefenseTypeCollectionViewCell"
    static let nibName = "DefenseTypeCollectionViewCell"

    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var damageLabel: UILabel!

    var weakness: Weakness?

    override func awakeFromNib() {
        super.awakeFromNib()
        imageContainerView.layer.cornerRadius = 5
    }

    func setData() {
        guard let data = weakness else { return }
        damageLabel.text = data.damageTaken == 1 ? "" :  data.damageTaken.getFractionString()
        typeImageView.image = UIImage(named: data.fromType.name)?.withRenderingMode(.alwaysTemplate)
        imageContainerView.backgroundColor = UIColor(named: "type-\(data.fromType.name)")
        typeImageView.tintColor = .white
    }
}
