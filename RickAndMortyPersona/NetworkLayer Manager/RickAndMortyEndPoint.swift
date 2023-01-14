//
//  RickAndMortyEndPoint.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import Foundation

enum RickAndMortyEndPoint: Endpoint {
    
    case getSearchhResults(name: String)
    case getPage(page: Int)
    case getEpisode(episode: String)

    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
     
    var baseURL: String {
        switch self {
        default:
            return "rickandmortyapi.com"
        }
    }
    
    var path: String {
        switch self {
        case .getSearchhResults:
            return "/api/character/"
            
        case .getPage(page: _):
            return "/api/character/"
            
        case .getEpisode(episode: let episode):
            return "/api/episode/" + episode
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getSearchhResults(let name):
            return [URLQueryItem(name: "name", value: name)]
            
        case .getPage(page: let currPage):
            return [URLQueryItem(name: "page", value: String(currPage))]
            
        case .getEpisode(_):
            return []
        }
        
    }
}

