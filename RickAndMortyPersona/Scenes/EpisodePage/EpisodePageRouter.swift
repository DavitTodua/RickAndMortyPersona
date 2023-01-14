//
//  EpisodePageRouter.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import Foundation

protocol EpisodePageRouter {
    
}

class EpisodePageRouterImpl: EpisodePageRouter {
    private weak var controller: EpisodePageViewController?
    
    init(controller: EpisodePageViewController?) {
        self.controller = controller
    }
}
