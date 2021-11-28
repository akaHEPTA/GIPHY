//
//  Gif.swift
//  GIPHY API
//
//  Created by Richard Cho on 2021-11-26.
//

import Foundation

struct Root: Codable {
    let data: [Gif]
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct Gif: Codable {
    let id: String
    let url: String
    let source: String
    let title: String
    let variants: Variants
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case source = "source"
        case title = "title"
        case variants = "images"
    }
    
    func getOriginalURL() -> String {
        return variants.original.url
    }

    func getDownsizedURL() -> String {
        return variants.downsized.url
    }
}

struct Variants: Codable {
    let original: Original
    let downsized: Downsized
    enum CodingKeys: String, CodingKey {
        case original = "original"
        case downsized = "fixed_width"
    }
}

struct Original: Codable {
    let height: String
    let url: String
}

struct Downsized: Codable {
    let height: String
    let url: String
}
