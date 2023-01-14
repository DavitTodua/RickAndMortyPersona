//
//  DetailsPageConfigurator.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import Foundation

protocol DetailsPageConfigurator {
    func configure(_ controller:DetailsPageViewController, characterDetails: RickAndMortyCharacter?)
}

class DetailsPageConfiguratorImpl: DetailsPageConfigurator {
    func configure(_ controller: DetailsPageViewController, characterDetails: RickAndMortyCharacter?) {
        
        let router: DetailsPageRouter = DetailsPageRouterImpl(controller)
        
        let presenter: DetailsPagePresenter = DetailsPagePresenterImpl(view: controller, router: router, characterDetails: characterDetails)
        
        controller.presenter = presenter
    }
}
