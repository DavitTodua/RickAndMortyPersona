//
//  MainPageConfigurator.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import Foundation

protocol MainPageConfigurator {
    func configure(MainPageViewController: MainPageViewController)
}

class MainPageConfiguratorImplementation: MainPageConfigurator {
    
    func configure(MainPageViewController: MainPageViewController) {
        let router: MainPageRouter = MainPageRouterImpl(MainPageViewController)
        
        let displayPageGateway = DisplayPageApiGatewayImp(restManager: RestManager())
        let displayPageUseCase = DisplayPageUseCaseImp(displayPageGateway: displayPageGateway)
        
        let searchNameApiGateway = SearchNameApiGatewayImp(restManager: RestManager())
        let searchNameUseCase = SearchNameUseCaseImp(searchedNameApiGateway: searchNameApiGateway)
        
        let presenter = MainPagePresenterImplementation(
            view: MainPageViewController,
            router: router,
            displayPageUseCase: displayPageUseCase,
            searchNameUseCase: searchNameUseCase)
        MainPageViewController.presenter = presenter
    }    
}
