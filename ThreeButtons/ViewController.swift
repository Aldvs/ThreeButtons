//
//  ViewController.swift
//  ThreeButtons
//
//  Created by admin on 04.11.2024.
//

import UIKit

class ViewController: UIViewController {

    let textForButtons = ["First Button", "Second Medium Button", "Third"]
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .center
        view.distribution = .fill
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let sideOffset = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        
        setupStackViewConstraints()
        setupButtons()
    }
    
    private func setupStackViewConstraints() {
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(self.sideOffset)).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -CGFloat(self.sideOffset)).isActive = true
    }
    
    private func setupButtons() {
        for (index, textForButton) in textForButtons.enumerated() {
            let button: UIButton = { configureButton(title: textForButton, needAction: index == 2) }()
            
            stackView.addArrangedSubview(button)
        }
    }
    
    private func configureButton(title: String, needAction: Bool) -> ScaleButton {
        let scaleButton = ScaleButton(configuration: .filled(title: title))
        
        scaleButton.configurationUpdateHandler = UIButton.blueFillUpdateHandler
        
        if needAction {
            scaleButton.addAction(UIAction(handler: { [weak self] _ in
                self?.openModalController()
            }), for: .touchUpInside)
        }
        
        scaleButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        return scaleButton
    }
    
    private func openModalController() {
        let controller = UIViewController()
        controller.view.backgroundColor = .white
        present(controller, animated: true)
    }
}

private extension UIButton {
    static let blueFillUpdateHandler: UIButton.ConfigurationUpdateHandler = { button in
        switch button.tintAdjustmentMode {
        case .dimmed:
            button.configuration?.background.backgroundColor = .systemGray
            button.configuration?.baseBackgroundColor = .systemGray2
        default:
            button.configuration?.background.backgroundColor = .systemBlue
            button.configuration?.baseForegroundColor = .white
        }
    }
}

private extension UIButton.Configuration {
    
    static func filled(title title: String) -> Self {
        var config: UIButton.Configuration = filled()
        
        config.title = title
        config.image = UIImage(systemName: "arrow.right.circle.fill")
        config.imagePadding = 9
        config.imagePlacement = .trailing
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        
        return config
    }
}

class ScaleButton: UIButton {
    
    private static var containerScale: CGFloat = 0.95
    private static var animationDuration: Double = 0.3
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: Self.animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.beginFromCurrentState, .allowUserInteraction]) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: Self.containerScale, y: Self.containerScale) : .identity
            }
        }
    }
}

