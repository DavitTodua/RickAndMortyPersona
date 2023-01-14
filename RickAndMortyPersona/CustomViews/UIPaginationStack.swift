//
//  UIPaginationStack.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

class UIPaginationStack: UIView {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let pagingLabel: UILabel = {
        let pagingLabel = UILabel()
        pagingLabel.textAlignment = .center

        
        pagingLabel.translatesAutoresizingMaskIntoConstraints = false
        return pagingLabel
    }()
    
    let rightButton: UIButton = {
        let rightButton = UIButton(type: .system)
        rightButton.titleLabel?.font = .boldSystemFont(ofSize: 16)

        rightButton.translatesAutoresizingMaskIntoConstraints = false
        return rightButton
    }()
    
    let leftButton: UIButton = {
        let leftButton = UIButton(type: .system)
        leftButton.titleLabel?.font = .boldSystemFont(ofSize: 16)

        leftButton.translatesAutoresizingMaskIntoConstraints = false
        return leftButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.addSubview(stackView)
        configureStackView()
        configureCorners()
        setButtonTitles()
        configurePagingLabel()
    }
    
    private func configureStackView() {
        addStackViewConstraints()
        addConstraintsToStackSubviews()
        addArrangedSubviews()
        stackView.backgroundColor = UIColor(named: "LightBlue")
    }
    
    private func addArrangedSubviews() {
        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(pagingLabel)
        stackView.addArrangedSubview(rightButton)
    }
    
    private func addStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func addConstraintsToStackSubviews() {
        NSLayoutConstraint.activate([
            leftButton.heightAnchor.constraint(equalToConstant: 35),
            leftButton.widthAnchor.constraint(equalToConstant: 50),
            rightButton.heightAnchor.constraint(equalToConstant: 35),
            rightButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configurePagingLabel() {
        pagingLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pagingLabel.text = "1"
    }
    
    private func configureCorners() {
        self.layer.cornerRadius = 14
        self.layer.masksToBounds = true
        leftButton.layer.cornerRadius = 10
        leftButton.layer.masksToBounds = true
        rightButton.layer.cornerRadius = 10
        rightButton.layer.masksToBounds = true
    }
    
    private func setButtonTitles() {
        rightButton.setTitle("Next", for: .normal)
        leftButton.setTitle("Prev", for: .normal)
    }
}
extension  UIPaginationStack {
    public func configureButtons(rightButtonAction:@escaping (()->()), leftButtonAction:@escaping (()->())) {
        
        self.rightButton.addAction {
            rightButtonAction()
        }
        self.leftButton.addAction {
            leftButtonAction()
        }
    }
    
    public func configure(model: UIPaginationStackModel) {
        self.pagingLabel.text = model.labelTitle
        if model.labelTitle == "1" {
            leftButton.isEnabled = false
        } else {
            leftButton.isEnabled = true
        }
        if model.labelTitle == model.maxPages {
            rightButton.isEnabled = false
        } else {
            rightButton.isEnabled = true
        }
        setupButtonColors(
            rightButtonBackgroundColor: model.rightButtonBackgroundColor,
            leftButtonBackgroundColor: model.leftButtonBackgroundColor,
            labelsTextColor: model.labelsTextColor)
    }
    
    public func configureLabel(labelTitle: String, maxPages: String) {
        pagingLabel.text = labelTitle
        if labelTitle == "1" {
            leftButton.isEnabled = false
        } else {
            leftButton.isEnabled = true
        }
        if labelTitle == maxPages {
            rightButton.isEnabled = false
        } else {
            rightButton.isEnabled = true
        }
    }
    
    
    
    private func setupButtonColors(rightButtonBackgroundColor: UIColor, leftButtonBackgroundColor: UIColor, labelsTextColor: UIColor) {
        leftButton.backgroundColor = leftButtonBackgroundColor
        rightButton.backgroundColor = rightButtonBackgroundColor
        leftButton.tintColor = labelsTextColor
        rightButton.tintColor = labelsTextColor
        pagingLabel.textColor = labelsTextColor
    }
}

extension UIPaginationStack {
    struct UIPaginationStackModel {
        let labelTitle: String
        let maxPages: String
        let rightButtonText: String
        let leftButtonText: String
        let rightButtonBackgroundColor: UIColor
        let leftButtonBackgroundColor: UIColor
        let labelsTextColor: UIColor
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}
