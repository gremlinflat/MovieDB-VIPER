//
//  ReviewEntity.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 23/09/22.
//

import Foundation

struct ReviewEntity: Codable {
    let id: String?
    let author: String
    let avatarPath: String?
    let content: String
}
