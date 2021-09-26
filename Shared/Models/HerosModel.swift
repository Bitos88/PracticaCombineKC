//
//  HeroesModel.swift
//  AppHerosCombine (iOS)
//
//  Created by Alberto Alegre Bravo on 19/9/21.
//

import Foundation

struct MarvelJson: Codable {
    let data: DataClass
    
}

struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results : [Results]
}

struct Results: Codable, Identifiable {
    let id: Int
    let name: String?
    let thumbnail: Thumbnail
    let title: String?
}


// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}



