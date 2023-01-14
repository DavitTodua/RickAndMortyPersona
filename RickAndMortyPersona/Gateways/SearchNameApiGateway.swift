//
//  SearchedNameApiGateway.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/24/22.
//

import Foundation

protocol SearchNameApiGateway {
    func fetchByName(name: String, completion: @escaping ((Result<RickAndMortyCharactersStruct, Error>) -> Void))
}

class SearchNameApiGatewayImp: SearchNameApiGateway {
    let restManager: RestManager
    
    init(restManager: RestManager) {
        self.restManager = restManager
    }
    
    func fetchByName(name: String, completion: @escaping ((Result<RickAndMortyCharactersStruct, Error>) -> Void)) {
        restManager.makeRequest(toEndPoint: RickAndMortyEndPoint.getSearchhResults(name: name), withHttpMethod: .get) { result in
            
            if let error = result.error {
                completion(Result.failure(error))
            }
            
            if let data = result.data {
                do {
                    let decodedData = try JSONDecoder().decode(RickAndMortyCharactersStruct.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    let empty = RickAndMortyCharactersStruct(results: [])
                    completion(.success(empty))
                }
            }
        }
    }
}
