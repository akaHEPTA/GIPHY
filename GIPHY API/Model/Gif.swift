//
//  Gif.swift
//  GIPHY API
//
//  Created by Richard Cho on 2021-11-26.
//

import Foundation

struct Root: Codable {
    let data: [Gif]
}

struct Gif: Codable {
    let url: URL
    let title: String
    struct images: Codable {
        struct original: Codable {
            let url: URL
        }
        struct downsized: Codable {
            let url: URL
        }
    }
}
