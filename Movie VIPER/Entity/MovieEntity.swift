//
//  MovieEntity.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 23/09/22.
//

import Foundation
import SwiftyJSON

struct MovieEntity: Codable {
    let id: Int
    let title: String
    
    let overview: String
    let tagline: String?
    
    let posterPath: String?
    let backdropPath: String?
    
    let releaseDate: String?
    let voteAverage: Double
    
    let youtubeID: String?
    
    
    
    init(from movieJson: JSON) {
        guard let movieJsonDict = movieJson.dictionaryObject else {
            id = -1
            title = ""
            overview = ""
            tagline = ""
            posterPath = ""
            backdropPath = ""
            releaseDate = ""
            voteAverage = 0
            youtubeID = ""
            return
        }
        id =  movieJsonDict["id"] as! Int
        title =  movieJsonDict["title"] as! String
        
        overview =  movieJsonDict["overview"] as! String
        tagline = movieJsonDict["tagline"] as? String
        
        posterPath =  movieJsonDict["poster_path"] as? String
        backdropPath =  movieJsonDict["backdrop_path"] as? String
        
        voteAverage =  movieJsonDict["vote_average"] as! Double
        releaseDate = movieJsonDict["release_date"] as? String
        
        guard let resultsList = movieJson.dictionary?["videos"]?.dictionary?["results"]?.array else {
            self.youtubeID = ""
            return
        }
        if resultsList.count > 0,  let youtubeID = resultsList[0].dictionary?["key"]?.string{
            self.youtubeID = youtubeID
        } else {
            self.youtubeID = ""
        }
    }
    
    func relaseYear() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        if let releaseDate = releaseDate , let dateFromString = dateFormatter.date(from: releaseDate) {
            //get only the year component
            dateFormatter.dateFormat = "yyy"
            return dateFormatter.string(from: dateFromString)
        }
        return nil
    }
}
