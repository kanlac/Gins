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
    
    func getTracks() -> [Track] {
        return tracks
    }
    
    func saveTracks(_ tracks: [Track]) {
        self.tracks = tracks
        
        print("newly caching data:\n \(tracks)")
        
        NotificationCenter.default.post(name: .updateViewNK, object: self, userInfo: nil)
    }
    
    func getLyrics() -> String {
        return lyrics
    }
    
    func saveLyrics(_ lyrics: String) {
        self.lyrics = lyrics
        
        // add post: lyrics data stored
    }
    
}
