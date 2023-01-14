//
//  ImageViewTableViewCell.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

class ImageViewTableViewCell: UITableViewCell {
    
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .boldSystemFont(ofSize: 22)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier
        )
        addSubviews()
        addConstraints()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.contentView.addSubview(mainImageView)
        self.contentView.addSubview(titleLabel)
        self.backgroundColor = UIColor(named: "BackgroundGreen")
    }
    
    private func addConstraints() {
        addConstraintsToMainImageView()
        addConstraintsToTitleLabel()
    }
    
    private func addConstraintsToMainImageView() {
        NSLayoutConstraint.activate([
            self.mainImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Spacing.XS.floatValue),
            self.mainImageView.heightAnchor.constraint(equalToConstant: 220),
            self.mainImageView.widthAnchor.constraint(equalToConstant: 240),
            self.mainImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    private func addConstraintsToTitleLabel() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: Spacing.S.floatValue),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -Spacing.S.floatValue),
            self.titleLabel.rightAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: -Spacing.S.floatValue),
            self.titleLabel.leftAnchor.constraint(greaterThanOrEqualTo: contentView.leftAnchor, constant: Spacing.S.floatValue),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
}
extension ImageViewTableViewCell {
    public func configure(image: UIImage?, urlString: String? = nil, title: String?, textColor: UIColor
    ) {
        self.titleLabel.text = title
        self.titleLabel.textColor = textColor
        if let urlString = urlString {
            mainImageView.loadImageUrl(urlString: urlString)
            return
        }
    }
}
