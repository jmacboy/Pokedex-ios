//
//  AdvancedFilterPopupViewController.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 7/7/22.
//

import UIKit

class AdvancedFilterPopupViewController: PopupViewController {
    @IBOutlet weak var contentStackView: UIStackView!

    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    lazy var viewmodel = {
        AdvancedFilterPopupViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setupContent()
    }
    
    func initViewModel() {
        viewmodel.closePopup = {[weak self] in
            self?.animateDismissView()
        }
    }
    
    func setupContent() {
        applyButton.layer.cornerRadius = 10
        resetButton.layer.cornerRadius = 10
        let spacer = UIView()
        contentStackView.addArrangedSubview(spacer)
        containerView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
    
    
    @IBAction func applyFilters(_ sender: Any) {
        viewmodel.applyFilters()
    }
    @IBAction func resetFilters(_ sender: Any) {
        viewmodel.resetFilters()
    }
}
