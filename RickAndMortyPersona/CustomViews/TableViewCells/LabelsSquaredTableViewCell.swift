//
//  LabelsSquaredTableViewCell.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

class LabelsSquaredTableViewCell: UITableViewCell {
    
    let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = .boldSystemFont(ofSize: 19)
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
    
    let statusImage: UIImageView = {
        let statusImage = UIImageView()
        statusImage.contentMode = .scaleAspectFill
        
        statusImage.translatesAutoresizingMaskIntoConstraints = false
        return statusImage
    }()
    
    let speciesLabel: UILabel = {
        let speciesLabel = UILabel()
        speciesLabel.font = .boldSystemFont(ofSize: 19)

        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        return speciesLabel
    }()
    
    let genderLabel: UILabel = {
        let genderLabel = UILabel()
        genderLabel.font = .boldSystemFont(ofSize: 19)

        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        return genderLabel
    }()
    
    let originLabel: UILabel = {
        let originLabel = UILabel()
        originLabel.font = .boldSystemFont(ofSize: 19)

        originLabel.translatesAutoresizingMaskIntoConstraints = false
        return originLabel
    }()
    
    let locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.font = .boldSystemFont(ofSize: 19)

        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        return locationLabel
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
        self.contentView.addSubview(statusImage)
        self.contentView.addSubview(speciesLabel)
        self.contentView.addSubview(genderLabel)
        self.contentView.addSubview(originLabel)
        self.contentView.addSubview(locationLabel)
    }
    
    private func addConstraints() {
        addConstraintsToStatusLabel()
        addConstraintsToStatusImage()
        addConstraintsToSpeciesLabel()
        addConstraintsToGenderLabel()
        addConstraintsToOriginLabel()
        addConstraintsToLocationLabel()
    }
    
    private func addConstraintsToStatusLabel() {
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Spacing.XS.floatValue),
            statusLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: Spacing.S.floatValue),
            statusLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: -Spacing.S.floatValue)
        ])
    }
    
    private func addConstraintsToStatusImage() {
        NSLayoutConstraint.activate([
            statusImage.leftAnchor.constraint(greaterThanOrEqualTo: statusLabel
                .rightAnchor, constant: 10),
            statusImage.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: -Spacing.S.floatValue),
            statusImage.centerYAnchor.constraint(equalTo: statusLabel.centerYAnchor),
            statusImage.heightAnchor.constraint(equalToConstant: Spacing.M.floatValue),
            statusImage.widthAnchor.constraint(equalToConstant: Spacing.M.floatValue)
        ])
    }
    
    private func addConstraintsToSpeciesLabel() {
        NSLayoutConstraint.activate([
            speciesLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: Spacing.XS.floatValue),
            speciesLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: Spacing.S.floatValue),
            speciesLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: -Spacing.S.floatValue)
        ])
    }
    
    
    private func addConstraintsToGenderLabel() {
        NSLayoutConstraint.activate([
            genderLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: Spacing.XS.floatValue),
            genderLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: Spacing.S.floatValue),
            genderLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: -Spacing.S.floatValue)
        ])
    }
    
    private func addConstraintsToOriginLabel() {
        NSLayoutConstraint.activate([
            originLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: Spacing.XS.floatValue),
            originLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: Spacing.S.floatValue),
            originLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: -Spacing.S.floatValue)
        ])
    }
    
    private func addConstraintsToLocationLabel() {
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: Spacing.XS.floatValue),
            locationLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: Spacing.S.floatValue),
            locationLabel.rightAnchor.constraint(lessThanOrEqualTo: self.contentView.rightAnchor, constant: -Spacing.S.floatValue),
            locationLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -Spacing.XS.floatValue)
        ])
    }
    
    
    
    
    private func setupContentView() {
        self.contentView.layer.cornerRadius = 12
        self.contentView.layer.masksToBounds = true
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    private func setupColors(backgroundColor: UIColor, textColor: UIColor) {
        self.contentView.backgroundColor = backgroundColor
        self.statusLabel.textColor = textColor
        self.speciesLabel.textColor = textColor
        self.genderLabel.textColor = textColor
        self.originLabel.textColor = textColor
        self.locationLabel.textColor = textColor
    }

}

extension LabelsSquaredTableViewCell {
    public func configure( model: LabelsSquaredModel) {
        self.statusLabel.text = "Status: " + (model.status ?? "")
        self.speciesLabel.text = "Species: " + (model.species ?? "")
        self.genderLabel.text = "Gender: " + (model.gender ?? "")
        self.originLabel.text = "Origin: " + (model.origin ?? "")
        self.locationLabel.text = "Location: " + (model.location ?? "")
        setupColors(backgroundColor: model.backgroundColor, textColor: model.textColor)        
    }
    
    struct LabelsSquaredModel {
        let status: String?
        let statusImage: UIImage?
        let species: String?
        let gender: String?
        let origin: String?
        let location: String?
        let backgroundColor: UIColor
        let textColor: UIColor
    }
}
