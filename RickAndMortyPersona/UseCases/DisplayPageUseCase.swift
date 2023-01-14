//
//  DisplayCharacter.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/20/22.
//

import Foundation

protocol DisplayPageUseCase {
    func displayPage(forPage pageNum: Int, completion: @escaping ((Result<RickAndMortyCharactersStruct, Error>)-> Void))
}

class DisplayPageUseCaseImp: DisplayPageUseCase {
    let displayPageGateway: DisplayPageApiGateway
    
    init(displayPageGateway: DisplayPageApiGateway) {
        self.displayPageGateway = displayPageGateway
    }
    
    func displayPage(forPage pageNum: Int, completion: @escaping ((Result<RickAndMortyCharactersStruct, Error>)-> Void)) {
        displayPageGateway.fetchPage(pageNum: pageNum) { result in
            switch result {
            case .success(let rickAndMortyStruct):
                completion(Result.success(rickAndMortyStruct))
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
}
