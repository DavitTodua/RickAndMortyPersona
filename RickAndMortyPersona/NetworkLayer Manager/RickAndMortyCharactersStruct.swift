//
//  RickAndMortyCodableStruct.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import Foundation



public struct RickAndMortyCharactersStruct: Codable {
    let results: [RickAndMortyCharacter]
}

    // MARK: - Result
struct RickAndMortyCharacter: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender {
    case female
    case male
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}

enum Species {
    case alien
    case human
    case unknown
}

enum Status {
    case alive
}

enum TypeEnum {
    case chair
    case clone
    case empty
    case pickle
}


struct RickAndMortyEpisodeStruct: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}


