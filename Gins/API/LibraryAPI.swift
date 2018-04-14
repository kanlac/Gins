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
    
    func requestData(url: String) {
        
        let cachedTracks = persistencyManager.getTracks()
        if cachedTracks.count > 0 {
            // update view..
            
        }
        // Check cached lyrics..
        
        lastfmClient.fetchTracks(url)
        
    }
    
    func encodeTracks() {
        persistencyManager.encodeTracks()
    }
    
}
