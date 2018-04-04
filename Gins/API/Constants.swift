//
//  Constants.swift
//  Gins
//
//  Created by serfusE on 2018/4/4.
//  Copyright © 2018 Dean. All rights reserved.
//

struct Constants {
    
    var username = "fablr"
    
    struct Last_fm {
        static let base_url = "https://ws.audioscrobbler.com/2.0/"
        
        struct Key {
            static let methods = "?method="
            static let format = "&format="
            static let api_key = "&api_key="
            
            static let artist = "&artist="
            static let album = "&album="
            static let track = "&track="
            static let user = "&user="
        }
        
        struct Value {
            static let format = "json"
            static let api_key = "a18c2fc72b817ad53fa22e3475c84053"
            
            static let user_getRecentTracks = "user.getRecentTracks"
            static let track_getInfo = "track.getInfo"
        }
    }
    
    struct Musixmatch {
        static let base_url = "https://api.musixmatch.com/ws/1.1/"
        
        struct Method {
            static let get_lyrics = "matcher.lyrics.get?"
        }
        
        struct Key {
            static let format = "format="
            static let callback = "&callback="
            static let track_name = "&q_track="
            static let artist_name = "&q_artist="
            static let api_key = "&apikey="
        }
        
        struct Value {
            static let format = "json"
            static let callback = "callback"
            static let api_key = "0d3981a4659e90c72a995e4d1179c5af"
        }
    }

}
