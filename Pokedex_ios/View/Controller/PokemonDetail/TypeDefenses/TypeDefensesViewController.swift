//
//  TypeDefensesViewController.swift
//  Pokedex_ios
//
//  Created by Yawar Valeriano on 7/21/22.
//

import UIKit

class TypeDefensesViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeCollection: UICollectionView!

    private let weaknesses: [Weakness]
    private let forType: String

    init(weaknesses: [Weakness], forType: String) {
        self.weaknesses = weaknesses
        self.forType = forType
        super.init(nibName: nil, bundle: nil)
    }

    required convenience init?(coder: NSCoder) {
        self.init(weaknesses: [], forType: "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.textColor = UIColor(named: "type-\(forType)")
        typeCollection.delegate = self
        typeCollection.dataSource = self
        typeCollection.register(UINib(nibName: DefenseTypeCollectionViewCell.nibName, bundle: nil),
                                forCellWithReuseIdentifier: DefenseTypeCollectionViewCell.identifier)
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
