//
//  displaySearchedNameUseCase.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/24/22.
//

import Foundation

protocol SearchNameUseCase {
    func fetchSearchedName(name: String, completion: @escaping ((Result<RickAndMortyCharactersStruct,Error>)-> Void))
}

class SearchNameUseCaseImp: SearchNameUseCase {
    let searchedNameApiGateway: SearchNameApiGateway
    
    init(searchedNameApiGateway: SearchNameApiGateway) {
        self.searchedNameApiGateway = searchedNameApiGateway
    }
    
    func fetchSearchedName(name: String, completion: @escaping ((Result<RickAndMortyCharactersStruct,Error>)-> Void)) {
        searchedNameApiGateway.fetchByName(name: name, completion: { result in
            switch result {
            case .success(let rickAndMortyStruct):
                completion(Result.success(rickAndMortyStruct))
            case .failure(let error):
                completion(Result.failure(error))
            }
        })
    }
}
