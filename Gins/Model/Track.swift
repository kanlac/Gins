//
//  Track.swift
//  Gins
//
//  Created by serfusE on 2018/4/4.
//  Copyright © 2018 Dean. All rights reserved.
//

import Foundation

enum CoverSize: String, Codable {
    case medium
    case large
}

struct Track: Codable {
    let title: String
    let artist: String
    let album: String
    let isPlaying: Bool
    let coverURL: [CoverSize: String]
}

extension Track: CustomStringConvertible {
    var description: String {
        return "------\n" + "track title: \(title)\n" + "artist: \(artist)\n" + "album: \(album)\n" + "is playing: \(isPlaying)\n" + "------"
    }
}
