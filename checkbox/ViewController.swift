//
//  ViewController.swift
//  checkbox
//
//  Created by 江啟綸 on 2022/9/1.
//

import UIKit
import Combine


class ViewController: UIViewController {
    
    private var store = Set<AnyCancellable>()
    
    
    private let backImage: UIImageView = {
        let backImage = UIImageView(image: UIImage(named: "10"))
        backImage.contentMode = .scaleAspectFill
        backImage.frame = CGRect(x: 0, y: 612, width: 375, height: 100)
        return backImage
    }()
    
    private let checkbox: Checkbox = {
        let viewModel = CheckboxViewModel(
            identifier: "Checkbox 0",
            description: "Subscribe o un like",
            type: .squareCheckmarkFill)
        let checkbox = Checkbox(viewModel: viewModel)
        return checkbox
    }()
    
    private let containerCheckboxesStackView: UIStackView  = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private let container2CheckboxesStackView: UIStackView  = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        title = "Checkbox"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    
    private func configUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(backImage)
        view.addSubview(checkbox)
        
        checkbox.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 20).isActive = true
        
        checkbox.leftAnchor.constraint(
            equalTo: view.leftAnchor,
            constant: 20).isActive = true
        
        checkbox.rightAnchor.constraint(
            equalTo: view.rightAnchor,
            constant: -20).isActive = true
        
        view.addSubview(containerCheckboxesStackView)
        containerCheckboxesStackView.topAnchor.constraint(
            equalTo: checkbox.bottomAnchor,
            constant: 20).isActive = true
        
        containerCheckboxesStackView.leftAnchor.constraint(
            equalTo: view.leftAnchor,
            constant: 20).isActive = true
        
        containerCheckboxesStackView.rightAnchor.constraint(
            equalTo: view.rightAnchor,
            constant: -20).isActive = true
        
        view.addSubview(container2CheckboxesStackView)
        container2CheckboxesStackView.topAnchor.constraint(
            equalTo: containerCheckboxesStackView.bottomAnchor,
            constant: 20).isActive = true
        
        container2CheckboxesStackView.leftAnchor.constraint(
            equalTo: view.leftAnchor,
            constant: 20).isActive = true
        
        container2CheckboxesStackView.rightAnchor.constraint(
            equalTo: view.rightAnchor,
            constant: -20).isActive = true
        
        
        for index in 1...3 {
            let checkbox: Checkbox = {
                let viewModel = CheckboxViewModel(
                    identifier: "Checkbox \(index)",
                    description: "Checkbox en Stack View \(index)",
                    type: .square)
                let checkbox = Checkbox(viewModel: viewModel)
                checkbox.setTintColor(color: .purple)
                return checkbox
            }()
            subscriptions(checkbox: checkbox)
            containerCheckboxesStackView.addArrangedSubview(checkbox)
        }
        
        for index in 1...5 {
            let checkbox: Checkbox = {
                let viewModel = CheckboxViewModel(
                    identifier: "Checkbox \(index)",
                    description: "Checkbox en Stack View \(index)",
                    type: .circleCheckMark)
                let checkbox = Checkbox(viewModel: viewModel)
                checkbox.setTintColor(color: .yellow)
                return checkbox
            }()
            subscriptions(checkbox: checkbox)
            container2CheckboxesStackView.addArrangedSubview(checkbox)
        }
        
        subscriptions(checkbox: checkbox)
        
    }
    
    private func subscriptions(checkbox: Checkbox) {
        checkbox.viewModelObserver.sink { checkboxViewModel in
            print(checkboxViewModel)
        }.store(in: &store)
    }
    
    
}

