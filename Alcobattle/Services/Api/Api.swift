//
//  Api.swift
//  Alcobattle
//
//  Created by Oleh on 29/08/2019.
//  Copyright © 2019 Oleh. All rights reserved.
//

import Foundation
import UIKit

struct UserCredentials: Codable {
    var email: String
    var password: String
}

struct UserData: Codable {
    var email: String
    var password: String
    var name: String
}

struct LoginResponse: Codable {
    var token: String
    var refresh: String
}

class Api {
    
    let baseUrl = "https://alcoapitest.azurewebsites.net"
    static let shared = Api()
    
    func fetchGenericData<T:Decodable>(_ url: String, httpMethod: HTTPMethod, completion: @escaping (T) -> ()) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
//        guard let msal = self.msal else { return }
//        request.setValue("\(msal.accessToken)", forHTTPHeaderField: "token")
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let error = err {
//                Log.e(object: error)
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
    
    func fetchGeneric<T:Decodable, D: Encodable>(_ url: String, httpMethod: HTTPMethod, dataSend: D,  completion: @escaping (T) -> ()) {

        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        
        let dataSend: D = dataSend
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let dataJson = try! encoder.encode(dataSend)

        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = dataJson
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            
            if let error = err {
//                Log.e(object: error)
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
    
    func postKudos(dataSend:UserCredentials, completion: @escaping (UserCredentials) -> ()){
        let urlString = UrlBuilder.shared.buildStringUrl(endpoint: .createUser)
        
//        guard let fetchService = self.fetchService else { return }
        fetchGeneric(urlString, httpMethod: .post, dataSend: dataSend){(kudosCompletion: UserCredentials) in
            completion(kudosCompletion)
        }
    }
    
    func getWeather(_ userData: UserCredentials){
        let session = URLSession(configuration: .default)
        var datatask : URLSessionDataTask?
        let url = "https://alcoapitest.azurewebsites.net"
        let myURL = URL(string: url)
        var request =  URLRequest(url: myURL!)
        request.allHTTPHeaderFields = ["email": userData.email, "password": userData.password, ]
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
    
    
//    -------------------------------------------------------

    
    func loginBasic(dataSend:UserCredentials, completion: @escaping (LoginResponse) -> ()){
        print("API level\(dataSend)")
        let urlString = UrlBuilder.shared.buildStringUrl(endpoint: .login)
        fetchGeneric(urlString, httpMethod: .post, dataSend: dataSend){(kudosCompletion: LoginResponse) in
            print(kudosCompletion)
            completion(kudosCompletion)
        }
    }
}

//struct LoginResponse: Codable {
//    var _id: String
//    var token: String
//    var refresh: String
//}

//_id
//:
//5e04e4a5c2f1788f1cebf08e
//email
//:
//"olegBob@mail.ru"
//password
//:
//"1234567890
