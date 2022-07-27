//
//  BaseStatsTableViewCell.swift
//  Pokedex_ios
//
//  Created by admin on 7/26/22.
//

import UIKit

class BaseStatsTableViewCell: UITableViewCell {
    
    static let nibName = "BaseStatsTableViewCell"
    static let identifier = "BaseStatsCell"
    
    @IBOutlet weak var descriptionStatLabel: UILabel!
    @IBOutlet weak var baseStatLabel: UILabel!
    @IBOutlet weak var statProgressView: UIProgressView!
    @IBOutlet weak var minStatLabel: UILabel!
    @IBOutlet weak var maxStatLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(stat: Stats, forType: String) {
        let percentProgress = Float(Float(stat.baseStat)/252)
        statProgressView.setProgress(percentProgress, animated: false)
        statProgressView.progressTintColor = UIColor(named: "type-\(forType)")

        //descriptionStatLabel.text = stat.stat.name
        baseStatLabel.text = "\(stat.baseStat)"
        setBaseTitle(title: stat.stat.name)
    }
    
    func setBaseTitle(title: String) {
        switch title {
        case "hp":
            self.descriptionStatLabel.text = "HP"
        case "attack":
            self.descriptionStatLabel.text = "Attack"
        case "defense":
            self.descriptionStatLabel.text = "Defense"
        case "special-attack":
            self.descriptionStatLabel.text = "Sp. Atk"
        case "special-defense":
            self.descriptionStatLabel.text = "Sp. Def"
        case "speed":
            self.descriptionStatLabel.text = "Speed"
        default:
            ""
        }
    }
}
