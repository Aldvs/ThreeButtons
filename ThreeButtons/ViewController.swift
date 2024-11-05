//
//  ViewController.swift
//  ThreeButtons
//
//  Created by admin on 04.11.2024.
//

import UIKit

class ViewController: UIViewController {

    let textForButtons = ["First Button", "Second Medium Button", "Third"]
    lazy var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stackView)
        
        setupStackView()
        configureButtons()
        
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
    }
    
    private func configureButtons() {
        for textForButton in textForButtons {
            let button = UIButton()
            button.setTitle(textForButton, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.backgroundColor = .systemBlue
            button.layer.cornerRadius = 20
            button.setTitleColor(.white, for: .normal)
            
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            stackView.addArrangedSubview(button)
        }
    }

}

