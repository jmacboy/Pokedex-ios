import UIKit

class ViewController: UIViewController {
    
    // Defined UI views
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Example"
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Filter Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = view.tintColor
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    
    lazy var containerStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [titleLabel, spacer, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 16.0
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        // Add action
        registerButton.addTarget(self, action: #selector(presentModalController), for: .touchUpInside)
    }
    
    func setupView() {
        
        view.backgroundColor = .systemBackground
    }
    
    // Add subviews and set constraints
    func setupConstraints() {
        view.addSubview(containerStackView)
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
       
        NSLayoutConstraint.activate([
           
            containerStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            containerStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -350),
            containerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            containerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
           
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
        
    @objc func presentModalController() {
        let vc = CustomModalViewController()
        vc.modalPresentationStyle = .overCurrentContext
        // modal animation will be handled in VC itself
        self.present(vc, animated: false)
    }
}

