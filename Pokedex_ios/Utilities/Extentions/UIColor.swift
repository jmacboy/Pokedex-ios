//
//  UIColor.swift
//  Pokedex_ios
//
//  Created by adri on 7/19/22.
//
import UIKit
import Foundation

extension UIColor {
    static var applyButtonColor: UIColor {
        return UIColor(named: ConstantVariables.applyButtonColor) ?? systemGray6
    }
    static var unAppliedButtonColor: UIColor {
        return UIColor.systemGray6
    }
}
