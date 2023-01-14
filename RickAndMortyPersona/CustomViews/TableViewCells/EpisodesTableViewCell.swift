//
//  EpisodesTableViewCell.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

class EpisodesTableViewCell: UITableViewCell {
    
    let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = .boldSystemFont(ofSize: 18)

        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    let rightButton: UIButton = {
        let rightButton = UIButton(type: .system)
        rightButton.setTitle("Show", for: .normal)
        rightButton.layer.cornerRadius = 10
        rightButton.layer.masksToBounds = true
        rightButton.titleLabel?.font = .preferredFont(forTextStyle: .body)
        rightButton.tintColor = .white

        rightButton.translatesAutoresizingMaskIntoConstraints = false
        return rightButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.contentView.addSubview(statusLabel)
        self.contentView.addSubview(rightButton)
    }
    
    private func addConstraints() {
        addStatusLabelConstraints()
        addRightButtonConstraints()
    }
    
    private func addStatusLabelConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Spacing.M.floatValue),
            statusLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: Spacing.M.floatValue),
            statusLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: -Spacing.XXL.floatValue),
            statusLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -Spacing.M.floatValue)
        ])
    }
    
    private func addRightButtonConstraints() {
        NSLayoutConstraint.activate([
            rightButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -Spacing.XS.floatValue),
            rightButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            rightButton.heightAnchor.constraint(equalToConstant: 32),
            rightButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupContentView() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = UIColor(named: "FrontGreen")
        self.selectionStyle = .none
    }
    
    private func roundCorners(corners: CornerChoice) {
        switch corners {
        case .TopCorners:
            self.contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .BottomCorners:
            self.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .allCorners:
            self.contentView.layer.masksToBounds = true
        }
        self.contentView.layer.cornerRadius = 12
    }
}

extension EpisodesTableViewCell {
    enum CornerChoice {
        case TopCorners
        case BottomCorners
        case allCorners
    }
}

extension EpisodesTableViewCell {
    public func configure(status: String?,
                          backgroundColor: UIColor,
                          textColor: UIColor,
                          roundCorners: CornerChoice?,
                          buttonAction: @escaping ((String)->())) {
        self.statusLabel.text = "Episode: " + (status ?? "")
        self.contentView.backgroundColor = backgroundColor
        self.statusLabel.textColor = textColor

        if let corners = roundCorners {
            self.roundCorners(corners: corners)
        }
        rightButton.backgroundColor = UIColor(named: "DarkBlue")
        rightButton.addAction(UIAction(handler: { action in
            buttonAction(self.statusLabel.text!)
        }), for: .touchUpInside)
    }
}
