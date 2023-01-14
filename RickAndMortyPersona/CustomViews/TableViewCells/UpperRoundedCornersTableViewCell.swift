//
//  UpperRoundedCornersTableViewCell.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

class UpperRoundedCornersTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        self.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    private func roundTopCorners() {
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    
    private func roundBottomCorners() {
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
}

extension UpperRoundedCornersTableViewCell {
    public func configure(backgroundColor: UIColor, corners: CornerChoice) {
        self.contentView.backgroundColor = backgroundColor
        
        switch corners {
        case .TopCorners:
            roundTopCorners()
        case .BottomCorners:
            roundBottomCorners()
        }
    }
    
    enum CornerChoice {
        case TopCorners
        case BottomCorners
    }
}


