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
    
    func setUpPokemonData<T: Decodable>(_ type: T.Type){
        
    }
    
}
