//
//  BigTitleCenteredView.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

class BigTitleCenterView: UIView {
    
    let bigTitle: UILabel = {
        let bigTitle = UILabel()
        bigTitle.font = UIFont(name: "Symbol", size: 20)
        
        bigTitle.translatesAutoresizingMaskIntoConstraints = false
        return bigTitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupBigTitleView()
        roundCorners()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBigTitleView() {
        self.addSubview(bigTitle)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            bigTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: Spacing.XXL.floatValue),
            bigTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Spacing.XXL.floatValue),
            bigTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func roundCorners() {
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
    }
}

extension BigTitleCenterView {
    public func configure(title: String, backgroundColor: UIColor) {
        self.bigTitle.text = title
        self.backgroundColor = backgroundColor
    }
}
