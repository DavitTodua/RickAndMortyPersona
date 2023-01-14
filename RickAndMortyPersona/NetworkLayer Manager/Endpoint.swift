//
//  Endpoint.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import Foundation

protocol Endpoint {
    //HTTP OR HTTPS
    var scheme: String { get }
    
    //rickandmortyapi.com
    var baseURL: String { get }
    
    // charactes/id/
    var path: String { get }
    
    // name: "apikey", value : API_KEY
    var parameters: [URLQueryItem] { get }
    
}

