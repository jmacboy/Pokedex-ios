//
//  BaseStatsTableViewCell.swift
//  Pokedex_ios
//
//  Created by admin on 7/26/22.
//

import UIKit

class BaseStatsTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionStatLabel: UILabel!
    @IBOutlet weak var baseStatLabel: UILabel!
    @IBOutlet weak var statProgressView: UIProgressView!
    @IBOutlet weak var minStatLabel: UILabel!
    @IBOutlet weak var maxStatLabel: UILabel!

    static let nibName = "BaseStatsTableViewCell"
    static let identifier = "BaseStatsCell"
    let minIv = 0
    let maxIv = 31
    let minEv = 0
    let maxEv = 252
    let minNature = 0.9
    let maxNature = 1.1
    let level = 100

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

        baseStatLabel.text = "\(stat.baseStat)"
        setBaseTitle(title: stat.stat.name, baseStat: stat.baseStat)
    }

    func setBaseTitle(title: String, baseStat: Int) {
        switch title {
        case "hp":
            self.descriptionStatLabel.text = "HP"
            self.calculateMinMaxForHp(baseStat: baseStat)
        case "attack":
            self.descriptionStatLabel.text = "Attack"
            self.calculateMixMaxForOtherStat(baseStat: baseStat)
        case "defense":
            self.descriptionStatLabel.text = "Defense"
            self.calculateMixMaxForOtherStat(baseStat: baseStat)
        case "special-attack":
            self.descriptionStatLabel.text = "Sp. Atk"
            self.calculateMixMaxForOtherStat(baseStat: baseStat)
        case "special-defense":
            self.descriptionStatLabel.text = "Sp. Def"
            self.calculateMixMaxForOtherStat(baseStat: baseStat)
        case "speed":
            self.descriptionStatLabel.text = "Speed"
            self.calculateMixMaxForOtherStat(baseStat: baseStat)
        default:
            "no desc."
        }
    }

    func calculateMinMaxForHp(baseStat: Int) {
        let minCalc = ((2 * baseStat + minIv + (minEv / 4)) * level) / 100
        let minHp = minCalc + level + 10

        let maxCalc = ((2 * baseStat + maxIv + (maxEv / 4)) * level) / 100
        let maxHp = maxCalc + level + 10

        minStatLabel.text = "\(minHp)"
        maxStatLabel.text = "\(maxHp)"
    }

    func calculateMixMaxForOtherStat(baseStat: Int) {
        let minCalc = ((2 * baseStat + minIv + (minEv / 4)) * level) / 100
        let min = Int(Double(minCalc + 5) * minNature)

        let maxCalc = ((2 * baseStat + maxIv + (maxEv / 4)) * level) / 100
        let max = Int(Double(maxCalc + 5) * maxNature)

        minStatLabel.text = "\(min)"
        maxStatLabel.text = "\(max)"
    }
}
