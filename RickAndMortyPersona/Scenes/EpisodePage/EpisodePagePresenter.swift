//
//  EpisodePagePresenter.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

protocol EpisodePagePresenter {
    func viewDidLoad()
    func getCellCount() -> Int
    func configureCell(cell: UITableViewCell, indexPath: IndexPath)
}

protocol EpisodePageView {
    func setupViews(titleName: String, date: String, serieNumber: String)
    func reloadTableView()
    func showError(localisedErrorString: String)
    func hideErrorMessage()
}

class EpisodePagePresenterImpl: EpisodePagePresenter {
    
    var router: EpisodePageRouter
    var view: EpisodePageView
    var episode: String
    var episodeStruct: RickAndMortyEpisodeStruct?
    let episodeDetailsUseCase: EpisodeDetailsUseCase
    
    init(view: EpisodePageView,
         router: EpisodePageRouter,
         episode: String,
         EpisodeDetailsUseCase: EpisodeDetailsUseCase) {
        self.view = view
        self.router = router
        self.episode = episode
        self.episodeDetailsUseCase = EpisodeDetailsUseCase
    }
    
    func viewDidLoad() {
        fetchCurrEpisode()
    }
        
    func fetchCurrEpisode() {
        episodeDetailsUseCase.fetchEpisode(episode: episode) { result in
            switch result {
            case .success(let decodedData):
                self.episodeStruct = decodedData
                DispatchQueue.main.async {
                    if let episodeStruct = self.episodeStruct {
                        self.view.hideErrorMessage()
                        self.view.setupViews(titleName: episodeStruct.name, date: episodeStruct.airDate, serieNumber: episodeStruct.episode)
                        self.view.reloadTableView()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view.showError(localisedErrorString: error.localizedDescription)
                }
            }
        }
    }
    
    func getCellCount() -> Int {
        return episodeStruct?.characters.count ?? 0
    }
    
    func configureCell(cell: UITableViewCell, indexPath: IndexPath) {
        cell.textLabel?.text = episodeStruct?.characters[indexPath.row]
    }
}


