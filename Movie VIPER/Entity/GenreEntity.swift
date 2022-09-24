//
//  GenreEntity.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import Foundation
import SwiftyJSON

struct GenreEntity: Codable {
    let id: Int
    let name: String
    
    init(from json: JSON) {
        
        guard let genreJson = json.dictionaryObject else {
            id = -1
            name = ""
            return
        }
        
        id = genreJson["id"] as! Int
        name = genreJson["name"] as! String

    }
}
//
