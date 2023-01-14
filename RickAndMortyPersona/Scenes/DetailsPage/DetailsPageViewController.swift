//
//  DetailsPageViewController.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

class DetailsPageViewController: UIViewController {
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var presenter: DetailsPagePresenter?
    
    private init(withConfigurator configurator: DetailsPageConfigurator, characterDetails: RickAndMortyCharacter?) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self, characterDetails: characterDetails)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailsPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        setupTableView()
        presenter?.viewDidLoad()
        self.view.backgroundColor
        = UIColor(named: "BackgroundGreen")
        navigationController?.navigationBar.barTintColor = UIColor(named: "BackgroundGreen")
    }
    
    private func addSubviews() {
        self.view.addSubview(tableView)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(ImageViewTableViewCell.self, forCellReuseIdentifier: "ImageViewTableViewCell")
        tableView.register(LabelsSquaredTableViewCell.self, forCellReuseIdentifier: "LabelsSquaredTableViewCell")
        tableView.backgroundColor = .clear
//        tableView.sectionHeaderTopPadding = 2
        tableView.sectionHeaderHeight = 2
        tableView.delegate = self
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Spacing.S.floatValue),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: Spacing.S.floatValue),
            tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: Spacing.S.floatValue),
            tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -Spacing.S.floatValue)
        ])
    }
}


extension DetailsPageViewController: DetailsPageView {
    
}

extension DetailsPageViewController {
    static func instantiate(configurator: DetailsPageConfigurator, characterDetails: RickAndMortyCharacter?) -> DetailsPageViewController {
        DetailsPageViewController(withConfigurator: configurator, characterDetails: characterDetails)
    }
}

extension DetailsPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        } else {
            return (presenter?.characterDetails?.episode.count ?? 0)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = ImageViewTableViewCell()
                cell.configure(image: nil, urlString: presenter?.characterDetails?.image, title: presenter?.characterDetails?.name, textColor: UIColor(named: "TextWhite")!)
                
                return cell
            }
            if indexPath.row == 1 {
                let cell = LabelsSquaredTableViewCell()
                presenter?.configureLabelsSquaredCell(cell: cell, indexpath: indexPath)
                
                return cell
            }
        }
            
        let cell = EpisodesTableViewCell()
        presenter?.configureEpisodeCell(cell: cell, indexpath: indexPath)
      
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
        {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
}
