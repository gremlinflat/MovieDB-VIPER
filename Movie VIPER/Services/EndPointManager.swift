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
    case movieTrailer(String)
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
                "sort_by" : "popularity.desc",
                "with_genres" : genre,
                "page" : "\(page)"
            ]
            
        case .movieDetails(let movieId):
            path = "/movie/\(movieId)"
            args = [
                "language" : "en-US"
            ]
            
        case .genre:
            path = "/genre/movie/list"
            args = [
                "language" : "en-US"
            ]
            
        case .movieTrailer(let movieId):
            path = "/movie/\(movieId)/videos"
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

        
        return "\(baseURL)\(path!)?api_key=\(SECRETS.movieApiKey)\(flattenArgs)"
    }
    
    func getImageURL(imgPath: String) -> String {
        return "\(baseImageURL)\(imgPath)"
    }
}
