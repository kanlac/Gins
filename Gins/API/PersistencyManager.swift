//
//  PersistencyManager.swift
//  Gins
//
//  Created by serfusE on 2018/4/6.
//  Copyright © 2018 Dean. All rights reserved.
//

import Foundation

final class PersistencyManager {
    
    private var tracks = [Track]()
    private var lyrics = String()
    
    init() {
        let savedURL = documents.appendingPathComponent(Filenames.Tracks)
        let data = try? Data(contentsOf: savedURL)
        if let tracksData = data,
            let decodedTracks = try? JSONDecoder().decode([Track].self, from: tracksData) {
            print("load existing data.")
            tracks = decodedTracks
        }
    }
    
    
    func getTracks() -> [Track] {
        return tracks
    }
    
    func saveTracks(_ tracks: [Track]) {
        self.tracks = tracks
        
        NotificationCenter.default.post(name: .tracksCachedNK, object: self, userInfo: nil)
    }
    
    func getLyrics() -> String {
        return lyrics
    }
    
    func saveLyrics(_ lyrics: String) {
        self.lyrics = lyrics
        
        NotificationCenter.default.post(name: .loadLyricsNK, object: nil)
    }
    
    // MARK: Implementing archiving and serialization
    
    private var documents: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private enum Filenames {
        static let Tracks = "tracks.json"
    }
    
    func encodeTracks() {
        let url = documents.appendingPathComponent(Filenames.Tracks)
        let encoder = JSONEncoder()
        guard let encodedData = try? encoder.encode(tracks) else {
            return
        }
        try? encodedData.write(to: url)
    }
    
}
