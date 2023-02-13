//
//  Spacings.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import Foundation

public enum Spacing: Int {
    case XS = 4
    case S = 8
    case M = 12
    case L = 16
    case L2 = 18
    case XL = 20
    case XXL = 32
    case XXL2 = 40
}

public extension Spacing {
    var floatValue: CGFloat {
        return CGFloat(integerLiteral: self.rawValue)
    }
}
