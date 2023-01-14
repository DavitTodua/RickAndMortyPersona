//
//  CollectionViewImageCell.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

class CollectionViewImageCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let statusLabel: UILabel = {
        let statusLabel = UILabel()
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    let statusImage: UIImageView = {
        let statusImage = UIImageView()
        statusImage.contentMode = .scaleToFill
        
        statusImage.translatesAutoresizingMaskIntoConstraints = false
        return statusImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        roundCorners()
        setupColors()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(statusLabel)
        self.contentView.addSubview(statusImage)
    }
    
    private func setupConstraints() {
        setupImageViewConstraints()
        setupTitleLabelConstraints()
        setupStatusLabelConstraints()
        setupStatusImageConstraints()
    }
    
    private func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Spacing.M.floatValue),
            imageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: Spacing.M.floatValue),
            imageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -Spacing.M.floatValue),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -Spacing.S.floatValue),
            imageView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            titleLabel.leftAnchor.constraint(lessThanOrEqualTo: self.contentView.leftAnchor, constant: Spacing.S.floatValue),
            titleLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: -Spacing.S.floatValue)
        ])
    }
    
    private func setupStatusLabelConstraints() {
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            statusLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -Spacing.M.floatValue),
            statusLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: Spacing.S.floatValue),
            statusLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: -Spacing.S.floatValue)
        ])
    }
    
    private func setupStatusImageConstraints() {
        NSLayoutConstraint.activate([
            statusImage.leftAnchor.constraint(greaterThanOrEqualTo: statusLabel
                .rightAnchor, constant: Spacing.S.floatValue),
            statusImage.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: -Spacing.S.floatValue),
            statusImage.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor),
            statusImage.heightAnchor.constraint(equalToConstant: 12),
            statusImage.widthAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    private func setupColors() {
        self.contentView.backgroundColor = UIColor(named: "FrontGreen")
        titleLabel.textColor = UIColor(named: "TextWhite")
        statusLabel.textColor = UIColor(named: "TextWhite")
    }
    
    private func roundCorners() {
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 12
        self.imageView.layer.masksToBounds = true
    }
}

extension CollectionViewImageCell {
    func configure(title: String, image: UIImage? = nil, ImageUrl: String, status: String, statusImage: UIImage?) {
        titleLabel.text = title
        if image != nil {
            imageView.image = image
        } else {
            imageView.loadImageUrl(urlString: ImageUrl)
        }
        statusLabel.text = status
        if statusImage != nil {
            self.statusImage.image = statusImage
        }
    }
}


