//
//  TypeDefensesViewController.swift
//  Pokedex_ios
//
//  Created by Yawar Valeriano on 7/21/22.
//

import UIKit

class TypeDefensesViewController: UIViewController {

    @IBOutlet weak var baseStatsLabel: UILabel!
    @IBOutlet weak var baseStatsTableView: UITableView!
    @IBOutlet weak var totalStatsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeCollection: UICollectionView!

    private let stats: [Stats]
    private let weaknesses: [Weakness]
    private let forType: String

    init(stats: [Stats], weaknesses: [Weakness], forType: String) {
        self.stats = stats
        self.weaknesses = weaknesses
        self.forType = forType
        super.init(nibName: nil, bundle: nil)
    }

    required convenience init?(coder: NSCoder) {
        self.init(stats: [], weaknesses: [], forType: "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.textColor = UIColor(named: "type-\(forType)")
        typeCollection.delegate = self
        typeCollection.dataSource = self
        typeCollection.register(UINib(nibName: DefenseTypeCollectionViewCell.nibName, bundle: nil),
                                forCellWithReuseIdentifier: DefenseTypeCollectionViewCell.identifier)
        setupBaseStatsView()
        calcTotal(stats: self.stats)
    }
    
    func setupBaseStatsView() {
        baseStatsLabel.textColor = UIColor(named: "type-\(forType)")
        baseStatsTableView.delegate = self
        baseStatsTableView.dataSource = self
        let uiNib = UINib(nibName: BaseStatsTableViewCell.nibName, bundle: nil)
        baseStatsTableView.register(uiNib, forCellReuseIdentifier: BaseStatsTableViewCell.identifier)
    }
    
    func calcTotal(stats: [Stats]) {
        var total = 0
        for stat in stats {
            total += stat.baseStat
        }
        totalStatsLabel.text = "\(total)"
    }
}

extension TypeDefensesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = baseStatsTableView.dequeueReusableCell(withIdentifier: BaseStatsTableViewCell.identifier, for: indexPath) as? BaseStatsTableViewCell
        ?? BaseStatsTableViewCell()

        let cellData = stats[indexPath.row]
        cell.setData(stat: cellData, forType: self.forType)
        return cell
    }
}

extension TypeDefensesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(ConstantVariables.pokemonTypes.count)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weakness = weaknesses[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefenseTypeCollectionViewCell.identifier, for: indexPath)
                as? DefenseTypeCollectionViewCell else { return UICollectionViewCell() }
        cell.weakness = weakness
        cell.setData()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 12
        let height = collectionView.frame.height / 2
        return CGSize(width: width, height: height)
    }

}
