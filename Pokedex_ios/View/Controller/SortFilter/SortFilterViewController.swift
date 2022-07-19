//
//  SortFilterViewController.swift
//  Pokedex_ios
//
//  Created by admin on 7/15/22.
//

import UIKit
import Foundation

protocol SortButtonActionDelegateDelegate: AnyObject {
    func sortButtonAction(pokemons: [PokemonRaw])
}

class SortFilterViewController: PopupViewController {
    @IBOutlet weak var contentStackView: UIStackView!
        @IBOutlet weak var sortLabel: UILabel!
        @IBOutlet weak var sortDescriptionLabel: UILabel!
        @IBOutlet weak var smallestNumberFirstButton: UIButton!
        @IBOutlet weak var heighestNumberFirstButton: UIButton!
        @IBOutlet weak var aToZButton: UIButton!
        @IBOutlet weak var zToAButton: UIButton!
       var sortPokemonListViewModel: SortPokemonListViewModel

       init(sortPokemonListViewModel: SortPokemonListViewModel) {
           self.sortPokemonListViewModel = sortPokemonListViewModel
           super.init(nibName: nil, bundle: nil)
       }

       override func viewDidLoad() {
           super.viewDidLoad()
           initViewModel()
           setupContent()
       }

       func initViewModel() {
           sortPokemonListViewModel.closePopup = {[weak self] in
               self?.animateDismissView()
           }
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       func setupContent() {
           smallestNumberFirstButton.layer.cornerRadius = 10
           heighestNumberFirstButton.layer.cornerRadius = 10
           aToZButton.layer.cornerRadius = 10
           zToAButton.layer.cornerRadius = 10
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
    func delayDismiss() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (_) in
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func smallestNumberFirstButton(_ sender: Any) {
        if let button: UIButton = sender as? UIButton {
            button.isSelected = !button.isSelected
            if button.isSelected {
               button.tintColor = UIColor.white
                button.backgroundColor = UIColor.applyButtonColor()
            } else {
               button.backgroundColor = UIColor.unAppliedButtonColor()
            }
        }
        sortPokemonListViewModel.sortWithSmallestNumberFirst()
        delayDismiss()
        }

    @IBAction func highestNumberFirst(_ sender: Any) {
        if let button: UIButton = sender as? UIButton {
             button.isSelected = !button.isSelected
            if button.isSelected {
               button.tintColor = UIColor.white
               button.backgroundColor = UIColor.applyButtonColor()
             } else {
               button.backgroundColor = UIColor.unAppliedButtonColor()
             }
         }
         sortPokemonListViewModel.sortWithHighestNumberFirst()
         delayDismiss()
        }

    @IBAction func aToZ(_ sender: Any) {
        if let button: UIButton = sender as? UIButton {
            button.isSelected = !button.isSelected
           if button.isSelected {
              button.tintColor = UIColor.white
              button.backgroundColor = UIColor.applyButtonColor()
            } else {
              button.backgroundColor = UIColor.unAppliedButtonColor()
            }
         }
         sortPokemonListViewModel.sortWithAtoZ()
         delayDismiss()
        }

     @IBAction func zToA(_ sender: Any) {
         if let button: UIButton = sender as? UIButton {
             button.isSelected = !button.isSelected
            if button.isSelected {
               button.tintColor = UIColor.white
            button.backgroundColor = UIColor.applyButtonColor()
             } else {
               button.backgroundColor = UIColor.unAppliedButtonColor()
             }
         }
         sortPokemonListViewModel.sortWithZtoA()
         delayDismiss()
       }
}

extension UIColor {
    class func applyButtonColor() -> UIColor {
        return UIColor(named: "apply-button") ?? UIColor.systemGray6
    }
    class func unAppliedButtonColor() -> UIColor {
        return UIColor.systemGray6
    }
}
