//
//  EpisodeDetailsUseCase.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/25/22.
//

import Foundation

protocol EpisodeDetailsUseCase {
    func fetchEpisode(episode: String, completion: @escaping ((Result<RickAndMortyEpisodeStruct, Error>) -> Void))
}

class EpisodeDetailsUseCaseImp: EpisodeDetailsUseCase {
    
    let episodeDetailsApiGateway: EpisodeDetailsApiGateway

    init(episodeDetailsApiGateway: EpisodeDetailsApiGateway) {
        self.episodeDetailsApiGateway = episodeDetailsApiGateway
    }

    func fetchEpisode(episode: String, completion: @escaping ((Result<RickAndMortyEpisodeStruct, Error>) -> Void)) {
        episodeDetailsApiGateway.getEpisodeDetails(episode: episode, completion: { result in
            switch result {
            case .success(let episodeStruct):
                completion(Result.success(episodeStruct))
            case .failure(let error):
                completion(Result.failure(error))
            }
        })
    }
}
