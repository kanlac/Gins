//
//  LastfmClient.swift
//  Gins
//
//  Created by serfusE on 2018/4/6.
//  Copyright © 2018 Dean. All rights reserved.
//

import Foundation

class LastfmClient {
    
    func fetchTracks(_ url: String) {
        
        let request = URL(string: url)!
        
        var results = [Track]()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                
                guard let data = data else {
                    print("No data returned.")
                    return
                }
                
                let parseResult: [String: AnyObject]!
                
                do {
                    
                    // parse track array.
                    
                    parseResult = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                    
                    guard let recentTracks = parseResult["recenttracks"] as? [String: AnyObject] else {
                        print("recentTracks parse error.")
                        return
                    }
                    guard let trackArray = recentTracks["track"] as? [[String: AnyObject]] else {
                        print("trackArray parse error.")
                        return
                    }
                    
                    // parse 10 latest track.
                    
                    for idx in 0..<10 {
                        
                        let currentTrack = trackArray[idx]
                        
                        guard let name = currentTrack["name"] as? String else {
                            print("name parse error.")
                            return
                        }
                        let isPlaying = currentTrack["@attr"] != nil
                        guard let latestArtistDic = currentTrack["artist"] as? [String: AnyObject], let latestArtist = latestArtistDic["#text"] as? String else {
                            print("latestArtistDic parse error")
                            return
                        }
                        guard let latestAlbumDic = currentTrack["album"] as? [String: AnyObject], let latestAlbum = latestAlbumDic["#text"] as? String else {
                            print("latestAlbumDic parse error.")
                            return
                        }
                        guard let latestImageArr = currentTrack["image"] as? [[String: AnyObject]] else {
                            print("image array parse error.")
                            return
                        }
                        
                        let largeImageURLString = latestImageArr[2]["#text"] as! String
                        let mediumImageURLString = latestImageArr[1]["#text"] as! String
                        let artworkURLs: [CoverSize: String] = [.large: largeImageURLString, .medium: mediumImageURLString]
                        
                        results.append(Track(title: name, artist: latestArtist, album: latestAlbum, isPlaying: isPlaying, coverURL: artworkURLs))
                        
                    }
                    
                    LibraryAPI.shared.saveTracks(results)
                    
                } catch {
                    print("Could not parse as JSON.")
                }
                
            } else {
                print(error ?? "Error (no message)")
            }
            }.resume()
        
    }
    
}
