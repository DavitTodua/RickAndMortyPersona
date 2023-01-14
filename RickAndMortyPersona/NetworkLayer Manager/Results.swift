//
//  Result.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/20/22.
//

import Foundation

struct Results {
    var data: Data?
    var response: Response?
    var error: Error?
    
    init(withData data: Data?, response: Response?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
 
    init(withError error: Error) {
        self.error = error
    }

}
