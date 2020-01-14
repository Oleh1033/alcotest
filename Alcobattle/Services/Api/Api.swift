//
//  Api.swift
//  Alcobattle
//
//  Created by Oleh on 29/08/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//

import Foundation
import UIKit

struct CreateUser {
    var name: String
    var surname: String
    var email: String
    var password: String
}

class Api {
    
    static let shared = Api()
    
    func getWeather(_ userData: CreateUser){
        let session = URLSession(configuration: .default)
        var datatask : URLSessionDataTask?
        let url = "asdasdasdasd"
        let myURL = URL(string: url)
        var request =  URLRequest(url: myURL!)
        request.allHTTPHeaderFields = ["name": userData.name, "surname": userData.surname, "email": userData.email, "password": userData.password, ]
        let task = session.dataTask(with: request, completionHandler: {data, response, error in
            if error == nil {
                let receivedData = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                print(receivedData)
            }
        })
        task.resume()
    }
    
    func loginBasic(completion: @escaping ([String]) -> ()){
        let urlString = UrlBuilder.shared.buildStringUrl(endpoint: .login)
        
        FetchService.shared.fetchGenericData(urlString, httpMethod: .get) {(data: [String]) in
            completion(data)
        }
    }
    
    func testRequest() {
        let url = URL(string: "https://a238c516.ngrok.io/login")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "login": "test",
            "password": "test"
        ]
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                    print("error", error ?? "Unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
//                Authorization.shared.token = response
                return
            }
            
            guard (300 ... 399) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        
        task.resume()
    }
}

