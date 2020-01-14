//
//  FetchService.swift
//  Alcobattle
//
//  Created by Oleh on 29/08/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//

import Foundation
import UIKit

class FetchService {
    
    static var shared = FetchService()
    
    func fetchGenericData<T:Decodable>(_ url: String, httpMethod: HTTPMethod, completion: @escaping (T) -> ()) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue

        request.setValue("AD234234SADSASDadsasd", forHTTPHeaderField: "token")
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let error = err {
                print(error)
            }
            guard let data = data else { return }
            do {
                let course = try JSONDecoder().decode(T.self, from: data)
                completion(course)
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
        }.resume()
    }
    
    func fetchImage(linkToImage: String, image: UIImageView) {
        
        func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
        }
        
        func downloadImage(from url: URL) {
            
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                    image.image = UIImage(data: data)
            }
        }
        
        guard let url = URL(string: linkToImage) else { return }
        downloadImage(from: url)
    }
}
