//
//  Cats.swift
//  CatApp
//
//  Created by Serkan on 18.04.2022.
//

import Foundation
import UIKit


struct Cats: Decodable {
    var name: String
    let temperament: String
    let origin: String
    let description: String
    let wikipediaUrl: String?
    let image: Image?
    enum CodingKeys: String, CodingKey {
        case name
        case temperament
        case origin
        case description
        case image
        case wikipediaUrl = "wikipedia_url"
    }
}

struct Image: Decodable {
    let id: String?
    var imageUrl: String?
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "url"
    }
}
