//
//  CustomError.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/25/22.
//

import Foundation

enum CustomError: Error {
    case failedToCreateRequest
    case failedToDecodeData
}

extension CustomError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .failedToCreateRequest: return NSLocalizedString("Unable to create the URLRequest object", comment: "")
        case .failedToDecodeData: return
            NSLocalizedString("Failed To Decode Data", comment: "")
        }
    }
}
