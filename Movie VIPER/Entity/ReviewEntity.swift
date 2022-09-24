//
//  ReviewEntity.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 23/09/22.
//

import Foundation
import SwiftyJSON

struct ReviewEntity: Codable, Identifiable {
    let id: String
    let author: String
    let avatarPath: String?
    let content: String
    let url: String
    init(from review: JSON) {
        id = review["id"].stringValue
        author =  (review["author_details"]["name"]).stringValue
        content = review["content"].stringValue
        url = review["url"].stringValue
        
        if (review["author_details"]["avatar_path"]).stringValue != "null" {
            avatarPath = (review["author_details"]["avatar_path"]).stringValue
        } else {
            avatarPath = nil
        }
    }
}
