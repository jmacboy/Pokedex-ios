//
//  PokemonTableViewCell.swift
//  Pokedex_ios
//
//  Created by admin on 6/29/22.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var infoContainer: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstTypeImageView: UIImageView!
    @IBOutlet weak var secondTypeImageView: UIImageView!
    @IBOutlet weak var pokemonImageView: UIImageView!

    lazy var viewModel = {
        PokemonListViewModel()
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCellDesign()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUpCellDesign() {
        infoContainer.layer.cornerRadius = 10
    }

    func setUpPokemonData(pokemon: PokemonRaw) {
        numberLabel.text = setPokemonNumber(id: pokemon.id)
        nameLabel.text = pokemon.name.capitalized
        if let image = viewModel.getPokemonsImageBy(id: pokemon.id) {
            pokemonImageView.image = image
        }

        guard let types = pokemon.pokemonDetails.first?.types else { return }
        setPokemonTypes(types: types)
    }

    func setPokemonNumber(id: Int) -> String {
        var number = ""
        switch id {
        case 0...9:
            number = "#00\(id)"
        case 10...99:
            number = "#0\(id)"
        case 100...999:
            number = "#\(id)"
        default:
            number = ""
        }

        return number
    }

    func setPokemonTypes(types: [TypeElement]) {
        self.secondTypeImageView.isHidden = true

        if let firstType = types.first {
            let imageName = "badge-\(firstType.type.name)"
            self.firstTypeImageView.image = UIImage(named: imageName)
            let backgroundColor = "background-type-\(firstType.type.name)"
            self.infoContainer.backgroundColor = UIColor(named: backgroundColor)
        }

        if let secondType = types.last, types.count > 1 {
            self.secondTypeImageView.isHidden = false
            let imageName = "badge-\(secondType.type.name)"
            self.secondTypeImageView.image = UIImage(named: imageName)
        }
    }

}
