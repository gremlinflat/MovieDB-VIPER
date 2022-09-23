//
//  MovieEntity.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 23/09/22.
//

import Foundation

struct MovieEntity: Codable {
    let title: String
    let overview: String
    let tagline: String
    
    let posterPath: String
    let backdropPath: String
    
    let releaseDate: Date
    let voteAverage: String
    let video: Bool
}
