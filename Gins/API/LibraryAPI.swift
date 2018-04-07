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
    
    // MARK: Public Methods
    
    func getTracks() -> [Track] {
        return persistencyManager.getTracks()
    }
    
    func loadData(url: String) {
        
        // tracks
        let tracks = fetchTracks(url)
        
        // lyrics
        let latest = tracks[0]
        let lyrics = fetchLyrics(title: latest.title, artist: latest.artist)
        
        // Save to cache
        persistencyManager.saveTracks(tracks)
        persistencyManager.saveLyrics(lyrics)
        
    }
    
    
    // MARK: Private Methods
    
    private func fetchTracks(_ url: String) -> [Track] {
        return lastfmClient.fetchTracks(url)
    }
    
    private func fetchLyrics(title: String, artist: String) -> String {
        return musixmatchClient.fetchLyrics(title: title, artist: artist)
    }
    
}
