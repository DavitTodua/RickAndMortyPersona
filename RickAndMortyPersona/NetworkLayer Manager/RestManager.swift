//
//  RestManager.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/20/22.
//

import Foundation

class RestManager {
    var httpBody: Data?
    
    var requestHttpHeaders = RestEntity()
    var httpBodyParameters = RestEntity()
    
    func makeRequest(toEndPoint endPoint: Endpoint,
                     withHttpMethod httpMethod: HttpMethod,
                     completion: @escaping (_ result: Results) -> Void) {
     
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            
            guard let targetURL = self?.buildURL(endPoint: endPoint) else {
                completion(Results(withError: CustomError.failedToCreateRequest))
                return
            }
            
            let httpBody = self?.getHttpBody()
           
            guard let request = self?.prepareRequest(withURL: targetURL, httpBody: httpBody, httpMethod: httpMethod) else
                {
                    completion(Results(withError: CustomError.failedToCreateRequest))
                    return
                }
            
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: request) { (data, response, error) in
                completion(Results(withData: data,
                                   response: Response(fromURLResponse: response),
                                   error: error))
            }
            task.resume()
        }
    }
        
    public func getData(fromURL url: URL, completion: @escaping (_ data: Data?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let data = data else { completion(nil); return }
                completion(data)
            })
            task.resume()
        }
    }
    
    private func buildURL(endPoint: Endpoint) -> URL? {
        var components = URLComponents()
        components.scheme = endPoint.scheme
        components.host = endPoint.baseURL
        components.path = endPoint.path
        components.queryItems = endPoint.parameters
        
        return components.url
    }
    
    private func getHttpBody() -> Data? {
        guard let contentType = requestHttpHeaders.value(forkey: "Content-Type") else { return nil }
    
        if contentType.contains("application/json") {
            return try? JSONSerialization.data(withJSONObject: httpBodyParameters.allValues(), options: [.prettyPrinted, .sortedKeys])
            } else if contentType.contains("application/x-www-form-urlencoded") {
                let bodyString = httpBodyParameters.allValues().map { "\($0)=\(String(describing: $1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))" }.joined(separator: "&")
                return bodyString.data(using: .utf8)
            } else {
                return httpBody
            }
    }
    
    private func prepareRequest(withURL url: URL?, httpBody: Data?, httpMethod: HttpMethod) -> URLRequest? {
    
        guard let url = url else { return nil }
           var request = URLRequest(url: url)
           request.httpMethod = httpMethod.rawValue
        
        for (header, value) in requestHttpHeaders.allValues() {
           request.setValue(value, forHTTPHeaderField: header)
        }

        request.httpBody = httpBody
        return request
    }
}
