//
//  LibraryAPI.swift
//  Gins
//
//  Created by serfusE on 2018/4/4.
//  Copyright © 2018 Dean. All rights reserved.
//

import Foundation

final class LibraryAPI {
    
    static let shared = LibraryAPI()
    
    private let persistencyManager = PersistencyManager()
    private let lastfmClient = LastfmClient()
    private let musixmatchClient = MusixmatchClient()
    
    // add notification observer..
    // init {}
    
    func fetchTracks(_ url: String) -> [Track] {
        return lastfmClient.fetchTracks(url)
    }
    
    func getLyrics(track: String, artist: String) -> String {
        return musixmatchClient.getLyrics(track: track, artist: artist)
    }
    
}
