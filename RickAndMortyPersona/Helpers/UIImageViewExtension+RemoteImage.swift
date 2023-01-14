//
//  UIImageViewExtension+RemoteImage.swift
//  RickAndMortyPersona
//
//  Created by David Todua on 12/10/22.
//

import UIKit

extension UIImageView {
    // We will go with URLSessions default cashing
    @discardableResult
    func loadImageUrl(urlString: String) -> URLSessionDataTask? {
        self.image = nil
        self.image = UIImage(named: "PlaceholderImage")
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let donwloadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = donwloadedImage
                }
            }
        }
        task.resume()
        return task
    }
}
