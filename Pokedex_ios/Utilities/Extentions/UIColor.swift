//
//  UIColor.swift
//  Pokedex_ios
//
//  Created by adri on 7/19/22.
//
import UIKit
import Foundation

extension UIColor {
    class func applyButtonColor() -> UIColor {
        return UIColor(named: "apply-button") ?? UIColor.systemGray6
    }
    class func unAppliedButtonColor() -> UIColor {
        return UIColor.systemGray6
    }
}
