//
//  AdvancedFilterPopupViewModel.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 5/7/22.
//

import Foundation

class AdvancedFilterPopupViewModel {
    var closePopup: (() -> Void)?
    @objc func applyFilters() {
        // TODO: Make all the filter logic here
        closePopup?()
    }
    func resetFilters() {
        // TODO: Make all the logic for reset the filters
    }
}
