//
//  BaseNetwork.swift
//  AppHerosCombine (iOS)
//
//  Created by Alberto Alegre Bravo on 19/9/21.
//

import Foundation


let scheme = "https"
let server = "https://gateway.marvel.com"
let publicKey = "1fe9fe2f27eab0b0b9cb545b8afb09ae"
let privateKey = "59ca16d44612871c60cc9554a1a7dbd06c08d3de"
let ts = "1"
let hash = "91678787760ace83bd4645960ada07ca"

struct HTTPMethods {
    
    static let post = "POST"
    static let get = "GET"
    static let content = "application/json"
    
}

enum endpoints : String {
    
    case heroeslist = "/v1/public/characters"
    
}

struct BaseNetwork{
    
    
    private func getUrlMarvel(endpoint: String, path: String = "") -> String {
        
        var url = server
        
        url += "\(endpoint)\(path)"
        url += "?apikey=\(publicKey)"
        url += "&ts=\(ts)"
        url += "&hash=\(hash)"
        
        print(url)
        
        return url
        
    }
    
    func getSessionCharacters() -> URLRequest {
        
        let urlCad : String = getUrlMarvel(endpoint: endpoints.heroeslist.rawValue)
        
        print(urlCad)
        
        var request : URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        return request
        
    }
    

    func getHeroSerie(filter: Int) -> URLRequest {
        
        let urlCad : String = getUrlMarvel(endpoint: endpoints.heroeslist.rawValue + String("/\(filter)/series"))
        
        print("url: \(urlCad)")
        
        var request : URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.get
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        
        return request
        
    }

    
}

