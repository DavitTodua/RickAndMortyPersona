//
//  EpisodeDetailsApiGateway.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/25/22.
//

import Foundation

protocol EpisodeDetailsApiGateway {
    func getEpisodeDetails(episode: String, completion: @escaping ((Result<RickAndMortyEpisodeStruct, Error>) -> Void))
}

class EpisodeDetailsApiGatewayImp: EpisodeDetailsApiGateway {
    let restManager: RestManager
    
    init(restManager: RestManager) {
        self.restManager = restManager
    }
    
    func getEpisodeDetails(episode: String, completion: @escaping ((Result<RickAndMortyEpisodeStruct, Error>) -> Void)) {
            restManager.makeRequest(toEndPoint: RickAndMortyEndPoint.getEpisode(episode: episode), withHttpMethod: .get) { result in
            
            if let error = result.error {
                completion(Result.failure(error))
            }
            
            if let data = result.data {
                do {
                    let decodedData = try JSONDecoder().decode(RickAndMortyEpisodeStruct.self, from: data)
                    completion(Result.success(decodedData))
                } catch {
                    completion(Result.failure(CustomError.failedToDecodeData))
                }
            }
        }
    }
}
