//
//  DoubleExtension.swift
//  Pokedex_ios
//
//  Created by Yawar Valeriano on 7/22/22.
//

import Foundation

extension Double {
    func getFractionStringForPokemonDefense() -> String {
        switch self {
        case 4.0:
            return "4"
        case 2.0:
            return "2"
        case 1.0:
            return ""
        case 0.5:
            return NSLocalizedString("\u{00BD}", comment: "1/2")
        case 0.25:
            return NSLocalizedString("\u{00BC}", comment: "1/4")
        default:
            return "N/V"
        }
    }
}
