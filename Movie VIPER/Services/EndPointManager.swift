//
//  EndPointManager.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 23/09/22.
//

import Foundation

enum EndPoints {
    case genre
    case movieList(String, Int)
    case movieDetails(String)
    case movieVideo(String)
    case imageAsset(String)
}

class EndPointFactory {
    
    static let shared: EndPointFactory = EndPointFactory()
    
    private init() { }
    
    //TODO: REFACTOR LATER
    let baseURL = "https://api.themoviedb.org/3"
    let baseImageURL = "https://image.tmdb.org/t/p/original"
    
    var path: String?
    var args: [String : String]?
    
    func configure(for endPoint: EndPoints) -> String{
        switch endPoint {
            
        case .movieList(let genre, let page):
            path = "/discover/movie"
            args = [
                "language" : "en-US",
                "include_adult" : "false",
                "with_genres" : genre,
                "page" : "\(page)"
            ]
            
        case .movieDetails(let id):
            path = "/discover/movie/\(id)"
            args = [
                "language" : "en-US"
            ]
            
        case .movieVideo(_):
            // TODO: UPDATE LATER
            fatalError()
            
        case .imageAsset(let imgPath):
            path = "\(baseImageURL)\(imgPath)"
            args = [:]
            
        case .genre:
            path = "\(baseURL)/genre/movie/list"
            args = [
                "language" : "en-US"
            ]
            
        }
        return getURL()
    }
    
    
    func getURL() -> String {
        var flattenArgs: String = ""
        args!.forEach { key, value in
            flattenArgs += "&\(key)=\(value)"
        }

        
        return "\(path!)?api_key=\(SECRETS.movieApiKey)\(flattenArgs)"
    }
}
