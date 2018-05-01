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
    private let iTunesClient = ITunesClient()
    
    func getTracks() -> [Track] {
        return persistencyManager.getTracks()
    }
    
    func saveTracks(_ tracks: [Track]) {
        persistencyManager.saveTracks(tracks)
    }
    
    func getLyrics() -> String {
        return persistencyManager.getLyrics()
    }
    
    func saveLyrics(_ lyrics: String) {
        persistencyManager.saveLyrics(lyrics)
    }
    
    func fetchLyrics(title: String, artist: String) {
        musixmatchClient.fetchLyrics(title: title, artist: artist)
    }
    
    // request for track list, then request lyrics automatically
    func requestData(url: String) {
        lastfmClient.fetchTracks(url)
    }
    
    func encodeTracks() {
        persistencyManager.encodeTracks()
    }
    
    func fetchArtworks(with query: String) -> [Artwork] {
        return iTunesClient.fetchArtworks(with: query)
    }
    
}
