//
//  EndPointManager.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 23/09/22.
//

import Foundation

protocol EndPointProtocol {
    var path: String { get }
    var args: [String:String] { get }
    func getURL() -> String
}

enum EndPoints {
    case movieList(String, Int)
    case movieDetails(String)
    case movieVideo(String)
    case imageAsset(String)
}

class EndPointManager: EndPointProtocol {
    //TODO: REFACTOR LATER
    let baseURL = "https://api.themoviedb.org/3"
    let baseImageURL = "https://image.tmdb.org/t/p/original"
    
    var path: String
    var args: [String : String]
    
    init(for endPoint: EndPoints) {
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
        }
    }
    
    func getURL() -> String {
        var flattenArgs: String = ""
        args.forEach { key, value in
            flattenArgs += "&\(key)=\(value)"
        }
        return "\(baseURL)\(path)?\(SECRETS.movieApiKey)\(flattenArgs)"
    }
}
