//
//  AdvancedFilterPopupController.swift
//  Pokedex_ios
//
//  Created by Alvaro Choque on 5/7/22.
//

import Foundation
import UIKit

class AdvancedFilterPopup: UIViewController {

    // Constants
    let defaultHeight: CGFloat = 350
    let dismissibleHeight: CGFloat = 500
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    // Keep current new height, initial is default height
    var currentContainerHeight: CGFloat = 300
    // Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    lazy var viewModel = {
        AdvancedFilterPopupViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initViewModel()
        setupConstraints()
        // tap gesture on dimmed view to dismiss
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        setupPanGesture()
        sheetPresentationController?.prefersGrabberVisible = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    // Setup the viewmodel for handling all the possible filters
    func initViewModel() {
        viewModel.closePopup = { [weak self] in
            self?.animateDismissView()
        }
    }
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
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()
}

/*
    MARK: Setup AdvancedFilterPopup
*/
extension AdvancedFilterPopup {
    @objc func handleCloseAction() {
        animateDismissView()
    }
    func setupView() {
        view.backgroundColor = .clear
    }
    func setupConstraints() {
        // Definning the views
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
            label.text = "Use advanced search to explore Pok[emon by type, weakness, height and more!"
            label.font = .systemFont(ofSize: 16)
            label.textColor = .darkGray
            label.numberOfLines = 0
            return label
        }()
        lazy var typesTitleLabel: UILabel = {
            let label = UILabel()
            label.text = "Types"
            label.font = .boldSystemFont(ofSize: 19)
            return label
        }()
        // TODO: Following labels should be uncomment when the implementation for respective filters is completed
    //
    //    lazy var weaknessTitleLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "Weaknesses"
    //        label.font = .boldSystemFont(ofSize: 19)
    //        return label
    //    }()
    //
    //    lazy var heightTitleLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "Heights"
    //        label.font = .boldSystemFont(ofSize: 19)
    //        return label
    //    }()
    //
    //    lazy var weightsTitleLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "Weights"
    //        label.font = .boldSystemFont(ofSize: 19)
    //        return label
    //    }()
        lazy var contentStackView: UIStackView = {
            let spacer = UIView()
            let stackView = UIStackView(arrangedSubviews: [lineView, titleLabel, notesLabel, typesTitleLabel, buttonsContainer, spacer])
            stackView.axis = .vertical
            stackView.spacing = 12.0
            return stackView
        }()
        // Add subviews
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        // Set static constraints
        NSLayoutConstraint.activate([
            // set dimmedView edges to superview
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // set container static constraint (trailing & leading)
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // content stackView
            contentStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            contentStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
        ])
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    func setupPanGesture() {
        // add pan gesture recognizer to the view controller's view (the whole screen)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        // change to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    // MARK: Pan gesture handler
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // Drag to top will be minus value and vice versa
        print("Pan gesture y offset: \(translation.y)")
        // Get drag direction
        let isDraggingDown = translation.y > 0
        print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
        // New height is based on value of dragging plus current container height
        let newHeight = currentContainerHeight - translation.y
        // Handle based on gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight < maximumContainerHeight {
                // Keep updating the height constraint
                containerViewHeightConstraint?.constant = newHeight
                // refresh layout
                view.layoutIfNeeded()
            }
        case .ended:
            // This happens when user stop drag,
            // so we will get the last height of container
            
            // Condition 1: If new height is below min, dismiss controller
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            }
            else if newHeight < defaultHeight {
                // Condition 2: If new height is below default, animate back to default
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                // Condition 3: If new height is below max and going down, set to default height
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            // Update container height
            self.containerViewHeightConstraint?.constant = height
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        // Save current height
        currentContainerHeight = height
    }
    // MARK: Present and dismiss animation
    func animatePresentContainer() {
        // update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    @objc func animateDismissView() {
        // hide blur view
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: false)
        }
        // hide main view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
}
