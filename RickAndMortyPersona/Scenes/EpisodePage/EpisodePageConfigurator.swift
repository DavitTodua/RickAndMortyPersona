//
//  EpisodePageConfigurator.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import Foundation

protocol EpisodePageConfigurator {
    func configure(_ viewController: EpisodePageViewController, episode: String)
}

class EpisodePageConfiguratorImpl: EpisodePageConfigurator {
    
    func configure(_ viewController: EpisodePageViewController, episode: String) {
        let router: EpisodePageRouter = EpisodePageRouterImpl(controller: viewController)
        
        let episodeDetailsApiGateway = EpisodeDetailsApiGatewayImp(restManager: RestManager())
        let episodeDetailsUseCase = EpisodeDetailsUseCaseImp(episodeDetailsApiGateway: episodeDetailsApiGateway)
        let presenter = EpisodePagePresenterImpl.init(view: viewController, router: router, episode: episode, EpisodeDetailsUseCase: episodeDetailsUseCase)
        
        viewController.presenter = presenter
    }
}

