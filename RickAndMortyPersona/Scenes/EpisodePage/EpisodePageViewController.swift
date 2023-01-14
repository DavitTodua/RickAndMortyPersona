//
//  EpisodePageViewControlleer.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

class EpisodePageViewController: UIViewController, EpisodePageView {
    
    let bigTitleCenterView: BigTitleCenterView = {
        let bigTitleCenterView = BigTitleCenterView()
        
        bigTitleCenterView.translatesAutoresizingMaskIntoConstraints = false
        return bigTitleCenterView
    }()
    
    let episodeLabel: UILabel = {
        let episodeLabel = UILabel()
        episodeLabel.font = .boldSystemFont(ofSize: 18)

        episodeLabel.translatesAutoresizingMaskIntoConstraints = false
        return episodeLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = .boldSystemFont(ofSize: 18)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.textColor = UIColor(named: "TextWhite")
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        return errorLabel
    }()
    
    var presenter: EpisodePagePresenter?
    
    private init(withConfigurator configurator: EpisodePageConfigurator, episode: String) {
        super.init(nibName: nil, bundle: nil)
        configurator.configure(self, episode: episode)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EpisodePageViewController {
    static func instantiate(configurator: EpisodePageConfigurator, episode: String) -> EpisodePageViewController {
        return EpisodePageViewController(withConfigurator: configurator, episode: episode)
    }
}

extension EpisodePageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        addSubviews()
        addConstraints()
        tableView.dataSource = self
        self.view.backgroundColor = UIColor(named: "BackgroundGreen")
    }
    
    private func addSubviews() {
        self.view.addSubview(bigTitleCenterView)
        self.view.addSubview(episodeLabel)
        self.view.addSubview(dateLabel)
        self.view.addSubview(errorLabel)
    }
    
    private func addConstraints() {
        setupBigTitleCenterViewConstraints()
        setupDateLabelConstraints()
        setupErrorLabelConstraints()
    }
    
    private func setupBigTitleCenterViewConstraints() {
        NSLayoutConstraint.activate([
            bigTitleCenterView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            bigTitleCenterView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            bigTitleCenterView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            bigTitleCenterView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func setupDateLabelConstraints() {
        NSLayoutConstraint.activate([
            episodeLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: Spacing.M.floatValue),
            episodeLabel.topAnchor.constraint(equalTo: bigTitleCenterView.bottomAnchor, constant: Spacing.M.floatValue),
            dateLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: Spacing.M.floatValue),
            dateLabel.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor, constant: Spacing.S.floatValue)
        ])
    }
    
    private func setupErrorLabelConstraints() {
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            errorLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            errorLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
        ])
        errorLabel.isHidden = true
    }
    
    func setupViews(titleName: String, date: String, serieNumber: String) {
        self.bigTitleCenterView.configure(title: titleName, backgroundColor: UIColor(named: "MilitaryGreen")!)
        self.episodeLabel.text = "Episode : " + serieNumber
        self.dateLabel.text = "Appear Date : " + date
        setupColors()
    }
    
    private func setupColors() {
        episodeLabel.textColor = UIColor(named: "TextWhite")
        dateLabel.textColor = UIColor(named: "TextWhite")
    }
    
    func showError(localisedErrorString: String) {
        errorLabel.text = localisedErrorString
        errorLabel.isHidden = false
    }
    
    func hideErrorMessage() {
        errorLabel.isHidden = true
    }
    
}

extension EpisodePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getCellCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        presenter?.configureCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }

}
