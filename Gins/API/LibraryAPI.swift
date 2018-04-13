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
    
    func saveTracks(_ tracks: [Track]) {
        persistencyManager.saveTracks(tracks)
    }
    
    func requestData(url: String) {
        
        let cachedTracks = persistencyManager.getTracks()
        if cachedTracks.count > 0 {
            // update view..
            
        }
        
        lastfmClient.fetchTracks(url)
        
    }
    
    
    // MARK: Private Methods
    
    private func fetchLyrics(title: String, artist: String) -> String {
        return musixmatchClient.fetchLyrics(title: title, artist: artist)
    }
    
}
