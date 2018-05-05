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
    private var artworks = [Artwork]()
    
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
        
        NotificationCenter.default.post(name: .updateTracksViewNK, object: self, userInfo: nil)
    }
    
    func getLyrics() -> String {
        return lyrics
    }
    
    func saveLyrics(_ lyrics: String) {
        self.lyrics = lyrics
        
        NotificationCenter.default.post(name: .loadLyricsNK, object: nil)
    }
    
    func saveArtworks(_ artworks: [Artwork]) {
        self.artworks = artworks
        
        NotificationCenter.default.post(name: .artworksFetchedNK, object: nil)
    }
    
    func getArtworks() -> [Artwork] {
        return artworks
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
