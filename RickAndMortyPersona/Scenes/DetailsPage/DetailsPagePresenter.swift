//
//  DetailsPagePresenter.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

protocol DetailsPageView: AnyObject {
    var imageView: UIImageView { set get }
    var titleLabel: UILabel { set get }
}

protocol DetailsPagePresenter {
    func viewDidLoad()
    var characterDetails: RickAndMortyCharacter? { get }
    func goToEpisode(episode: String)
    func getEpisodeFromString(episodeString: String) -> String?
    func configureEndingCells(indexPath: IndexPath, cell: UpperRoundedCornersTableViewCell)
    func configureLabelsSquaredCell(cell: LabelsSquaredTableViewCell, indexpath: IndexPath)
    func configureEpisodeCell(cell: EpisodesTableViewCell, indexpath: IndexPath)
}

class DetailsPagePresenterImpl: DetailsPagePresenter {
    
    var view: DetailsPageView?
    var router: DetailsPageRouter
    var characterDetails: RickAndMortyCharacter?
    
    init(view: DetailsPageView? = nil, router: DetailsPageRouter, characterDetails: RickAndMortyCharacter?) {
        self.view = view
        self.router = router
        self.characterDetails = characterDetails
    }
    
    func viewDidLoad() {
        configureDetailsView()
    }
    
    private func configureDetailsView() {
        if let imageUrl = characterDetails?.image {
            self.view?.imageView.loadImageUrl(urlString: imageUrl)
        }
        self.view?.titleLabel.text = characterDetails?.name
    }
    
    func goToEpisode(episode: String) {
        router.goToEpisode(episode: urlStringFromEpisode(episode: episode))
    }
    
    func getEpisodeFromString(episodeString: String) -> String? {
        if let range = episodeString.range(of: "https://rickandmortyapi.com/api/episode/") {
            let episode = episodeString[range.upperBound...]
            return String(episode)
        } else {
            return nil
        }
    }
    
    func configureEndingCells(indexPath: IndexPath, cell: UpperRoundedCornersTableViewCell) {
        if indexPath.row == 0 {
            cell.configure(backgroundColor: UIColor(named: "FrontGreen")!, corners: .TopCorners)
        } else {
            cell.configure(backgroundColor: UIColor(named: "FrontGreen")!, corners: .BottomCorners)
        }
    }
    
    func configureEpisodeCell(cell: EpisodesTableViewCell, indexpath: IndexPath) {
        var roundCorners: EpisodesTableViewCell.CornerChoice? = nil
        
        if indexpath.row == 0 {
            roundCorners = .TopCorners
        } else if indexpath.row == (characterDetails?.episode.count ?? 2)-1 {
            roundCorners = .BottomCorners
        }
         
        if self.characterDetails?.episode.count == 1 {
            roundCorners = .allCorners
        }
        
        let episodeString = self.characterDetails?.episode[indexpath.row]
        let episode = self.getEpisodeFromString(episodeString: episodeString!)
        cell.configure(
            status: episode,
            backgroundColor: UIColor(named: "FrontGreen")!,
            textColor: UIColor(named: "TextWhite")!, roundCorners: roundCorners)
        { [unowned self] currEpisode in
            self.goToEpisode(episode: currEpisode)
        }
    }
    
    func configureLabelsSquaredCell(cell: LabelsSquaredTableViewCell, indexpath: IndexPath) {
        cell.configure(
            model: .init(
                status: characterDetails?.status,
                statusImage: nil,
                species: characterDetails?.species,
                gender: characterDetails?.gender,
                origin: characterDetails?.origin.name,
                location: characterDetails?.location.name,
                backgroundColor: UIColor(named: "FrontGreen")!,
                textColor: UIColor(named: "TextWhite")!))
    }
    
    func urlStringFromEpisode(episode: String)-> String {
        let range = episode.range(of:"Episode: " )
        let episodeNumber = episode[range!.upperBound...]
        
        return String(episodeNumber)
    }
}
