//
//  MainPageRouter.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

protocol MainPageRouter {
    func MoveToDetailsPage(characterDetails: RickAndMortyCharacter?)
}

class MainPageRouterImpl: MainPageRouter {
    
    private weak var controller: UIViewController?
    
    init(_ controller: UIViewController?) {
        self.controller = controller
    }
    
    func MoveToDetailsPage(characterDetails: RickAndMortyCharacter?) {
        let vc = DetailsPageViewController.instantiate(configurator: DetailsPageConfiguratorImpl(), characterDetails: characterDetails)
        self.controller?.navigationController?.pushViewController(vc, animated: true)
    }
}
