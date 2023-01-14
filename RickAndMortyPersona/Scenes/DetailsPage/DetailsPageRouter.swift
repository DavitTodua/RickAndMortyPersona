//
//  DetailsPageRouter.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import Foundation

protocol DetailsPageRouter {
    func goToEpisode(episode: String)
}

class DetailsPageRouterImpl: DetailsPageRouter {
    private weak var controller: DetailsPageViewController?
    
    init(_ controller: DetailsPageViewController) {
        self.controller = controller
    }
    
    func goToEpisode(episode: String) {
        let vc = EpisodePageViewController.instantiate(configurator: EpisodePageConfiguratorImpl(), episode: episode)
        self.controller?.navigationController?.pushViewController(vc, animated: true)
    }
}
