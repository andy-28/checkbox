//
//  checkbox.swift
//  checkbox
//
//  Created by 江啟綸 on 2022/9/1.
//

import UIKit
import Combine


struct CheckboxViewModel {
    let identifier: String
    let description: String
    var isChecked: Bool
    let type: CheckboxType
    
    init(identifier: String,
         description: String,
         isChecked: Bool = false,
         type: CheckboxType = .square
    ) {
        self.identifier = identifier
        self.description = description
        self.isChecked = isChecked
        self.type = type
    }
}


enum CheckboxType {
    case circle, square, circleCheckMark, squareCheckmark, squareCheckmarkFill
    
    var unCheckedIcon: UIImage {
        switch self {
        case .circle:
            return UIImage(systemName: "circle")!
        case .square:
            return UIImage(systemName: "square")!
        case .circleCheckMark:
            return UIImage(systemName: "circle")!
        case .squareCheckmark:
            return UIImage(systemName: "square")!
        case .squareCheckmarkFill:
            return UIImage(systemName: "square")!
        }
    }
    
    var checkedIcon: UIImage {
        switch self {
        case .circle:
            return UIImage(systemName: "circle.fill")!
        case .square:
            return UIImage(systemName: "square.fill")!
        case .circleCheckMark:
            return UIImage(systemName: "checkmark.circle")!
        case .squareCheckmark:
            return UIImage(systemName: "checkmark.square")!
        case .squareCheckmarkFill:
            return UIImage(systemName: "checkmark.square.fill")!
        }
    }
}

final class Checkbox: UIStackView {
    
    private var viewModel: CheckboxViewModel
    
    let viewModelObserver = PassthroughSubject<CheckboxViewModel, Never>()
    
    private lazy var checkbox: UIButton = {
        let button = UIButton(primaryAction: checkboxAction())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 24).isActive = true
        button.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return button
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private let paddingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        return view
    }()
    
    private let containerLabelStackView = UIStackView()
    
    init(viewModel: CheckboxViewModel){
        self.viewModel = viewModel
        super.init(frame: .zero)
        configUI()
        configData()
        updateUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func checkboxAction() -> UIAction{
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.isChecked.toggle()
            self.updateUI()
            self.viewModelObserver.send(self.viewModel)
        }
    }

    private func updateUI() {
        if viewModel.isChecked {
            checkbox.setImage(viewModel.type.checkedIcon, for: .normal)
            
            let attributedString = NSMutableAttributedString(string: descriptionLabel.text!)
            
            attributedString.addAttribute(.strikethroughStyle, value: NSNumber(value: NSUnderlineStyle.single.rawValue), range: NSMakeRange(0, attributedString.length))
            
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray],range: NSMakeRange(0, attributedString.length))
            
            attributedString.addAttribute(.strikethroughColor, value: UIColor.black, range: NSMakeRange(0, attributedString.length))
            
            descriptionLabel.attributedText = attributedString
            
        } else {
            checkbox.setImage(viewModel.type.unCheckedIcon, for: .normal)
            let attributedString = NSMutableAttributedString(string: descriptionLabel.text!)
            
            descriptionLabel.attributedText = attributedString
            
            
        }
    }
    
    private func configData() {
        descriptionLabel.text = viewModel.description
    }
    
    private func configUI() {
        addArrangedSubview(checkbox)
        addArrangedSubview(containerLabelStackView)
        containerLabelStackView.addArrangedSubview(paddingView)
        containerLabelStackView.addArrangedSubview(descriptionLabel)
        containerLabelStackView.axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
        alignment = .top
        spacing = 10
        
    }
    
    func setTintColor(color: UIColor) {
        checkbox.tintColor = color
    }
}

