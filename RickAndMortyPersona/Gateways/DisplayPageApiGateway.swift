//
//  DisplayCharacterApiGateway.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/24/22.
//

import Foundation

protocol DisplayPageApiGateway {
    func fetchPage(pageNum: Int, completion: @escaping ((Result<RickAndMortyCharactersStruct, Error>)-> Void))
}

class DisplayPageApiGatewayImp: DisplayPageApiGateway {
    let restManager: RestManager
    
    init(restManager: RestManager) {
        self.restManager = restManager
    }
    
    func fetchPage(pageNum: Int, completion: @escaping ((Result<RickAndMortyCharactersStruct, Error>)-> Void)) {
        restManager.makeRequest(toEndPoint: RickAndMortyEndPoint.getPage(page: pageNum), withHttpMethod: .get) { result in
            
            if let error = result.error {
                completion(Result.failure(error))
            }
            
            if let data = result.data {
                do {
                    let decodedData = try JSONDecoder().decode(RickAndMortyCharactersStruct.self, from: data)
                    
                    completion(.success(decodedData))
                } catch {
                    completion(Result.failure(CustomError.failedToDecodeData))
                }
            }
        }
    }
}

