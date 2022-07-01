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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpPokemonData(pokemon: PokemonRaw){
        numberLabel.text = setPokemonNumber(id: pokemon.id)
        nameLabel.text = pokemon.name
        
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
        
        if let firstType = types.first {
            let imageName = "badge-\(firstType.type.name)"
            self.firstTypeImageView.image = UIImage(named: imageName)
        }
        
        if let secondType = types.last, types.count > 1 {
            let imageName = "badge-\(secondType.type.name)"
            self.secondTypeImageView.image = UIImage(named: imageName)
        }
    }
    
}
