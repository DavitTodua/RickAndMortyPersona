//
//  EntityAndResponse.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/20/22.
//

import Foundation

struct RestEntity {
    private var values: [String: String] = [:]
    
    mutating func add(value: String, forKey key: String) {
        values[key] = value
    }
    
    func value(forkey key: String) -> String? {
        return values[key]
    }
    
    func allValues() -> [String: String] {
        return values
    }
    
    func totalItems() -> Int {
        return values.count
    }
}

struct Response {
    var response: URLResponse?
    var httpStatusCode: Int = 0
    var headers = RestEntity()
    
    init(fromURLResponse response: URLResponse?) {
       guard let response = response else { return }
       self.response = response
       httpStatusCode = (response as? HTTPURLResponse)?.statusCode ?? 0

       if let headerFields = (response as? HTTPURLResponse)?.allHeaderFields {
           for (key, value) in headerFields {
               headers.add(value: "\(value)", forKey: "\(key)")
           }
       }
    }
}
