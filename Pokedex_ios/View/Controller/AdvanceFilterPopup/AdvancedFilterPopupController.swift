//
//  AdvancedFilterPopupController.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 5/7/22.
//

import Foundation
import UIKit

class AdvancedFilterPopup: PopupViewController {
    lazy var lineView: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.frame = CGRect(x: 0, y: -200, width: 30, height: 350)
        return line
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Filters"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    lazy var notesLabel: UILabel = {
        let label = UILabel()
        label.text = "Use advanced search to explore Pokémon by type, weakness, height and more!"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    lazy var viewModel = {
        AdvancedFilterPopupViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setupContent()
    }
    func initViewModel() {
        viewModel.closePopup = { [weak self] in
            self?.animateDismissView()
        }
    }
    func setupContent() {
        lazy var resetButton: UIButton = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            button.backgroundColor = UIColor(named: "cancel-button")
            button.setTitle("Reset", for: .normal)
            button.setTitleColor(UIColor(named: "TextGreyColor"), for: .normal)
            button.layer.cornerRadius = 10
            return button
        }()
        lazy var applyButton: UIButton = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            button.backgroundColor = UIColor(named: "apply-button")
            button.setTitle("Apply", for: .normal)
            button.layer.cornerRadius = 10
            // Setup the method
            button.addTarget(viewModel, action: #selector(viewModel.applyFilters), for: .touchUpInside)
            return button
        }()
        lazy var buttonsContainer: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [resetButton, applyButton])
            stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            stackView.axis = .horizontal
            stackView.spacing = 10.0
            stackView.distribution = .fillEqually
            return stackView
        }()
        lazy var contentStackView: UIStackView = {
            let spacer = UIView()
            let stackView = UIStackView(arrangedSubviews: [lineView, titleLabel, notesLabel, buttonsContainer, spacer])
            stackView.axis = .vertical
            stackView.spacing = 12.0
            return stackView
        }()
        containerView.addSubview(contentStackView) // <- this line is important to add the content to the popup container
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
}
