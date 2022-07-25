//
//  DoubleExtension.swift
//  Pokedex_ios
//
//  Created by Yawar Valeriano on 7/22/22.
//

import Foundation

extension Double {
    func getFractionString(withPrecision eps: Double = 1.0E-6) -> String {
        var x = self
        var a = floor(x)
        var (h1, k1, h, k) = (1, 0, Int(a), 1)
        while x - a > eps * Double(k) * Double(k) {
            x = 1.0/(x - a)
            a = floor(x)
            (h1, k1, h, k) = (h, k, h1 + Int(a) * h, k1 + Int(a) * k)
        }
        return k == 1 ? "\(h)" : "\(h)/\(k)"
    }
}
