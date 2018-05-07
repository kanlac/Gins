//
//  ITunesClient.swift
//  Gins
//
//  Created by serfusE on 2018/5/1.
//  Copyright © 2018 Dean. All rights reserved.
//

import Foundation
import os.log

class ITunesClient {
    
    func fetchArtworks(with query: String) {
        
        let requestString = Constants.iTunesStore.base_url + Constants.iTunesStore.Key.term + query + Constants.iTunesStore.Key.media + Constants.iTunesStore.Value.media + Constants.iTunesStore.Key.entity + Constants.iTunesStore.Value.entity
        let encodedRequestString = requestString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let request = URL(string: encodedRequestString)!

        var artworks = [Artwork]()
        print("request url: \(encodedRequestString)")

        URLSession.shared.dataTask(with: request) { (data, error, response) in
            
            guard let data = data else {
                print("No data returned.")
                return
            }
            
            var parseResult: [String: AnyObject]
            
            do {
                parseResult = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                
                guard let results = parseResult["results"] as? [NSDictionary], let resultCount = parseResult["resultCount"] as? Int else {
                    print("results & resultCount parse error.")
                    return
                }
                
                if resultCount > 0 {
                    
                    for i in 0..<resultCount {
                        let body = results[i]
                        guard let collectionName = body["collectionName"],
                            let artistName = body["artistName"],
                            let artworkUrl100 = body["artworkUrl100"] else {
                                print("Artworks data parse error. Number: \(i)")
                                return
                        }
                        
                        // Save as Artwork object..
                        
                        let artwork = Artwork(title: collectionName as! String, artist: artistName as! String, artworkURLString: artworkUrl100 as! String)
                        
                        print("appending artwork: \(artwork)")
                        artworks.append(artwork)
                        
                    }
                    LibraryAPI.shared.saveArtworks(artworks)
                    
                } else {
                    print("No artworks fetched from iTunes.")
                }
                
            } catch {
                print("Could not parse as JSON.")
            }
            
        }.resume()
        
    }
    
}
