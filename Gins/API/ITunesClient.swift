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
    
    func fetchArtworks(with query: String) -> [Artwork] {
        
        let requestString = Constants.iTunesStore.base_url + Constants.iTunesStore.Key.term + query + Constants.iTunesStore.Key.media + Constants.iTunesStore.Value.media + Constants.iTunesStore.Key.entity + Constants.iTunesStore.Value.entity
        let encodedRequestString = requestString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let request = URL(string: encodedRequestString)!

        var artworks = [Artwork]()

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
                
                let body = results[0]
                guard let collectionName = body["collectionName"],
                    let artistName = body["artistName"],
                    let artworkUrl100 = body["artworkUrl100"] else {
                        print("Artworks data parse error.")
                        return
                }
                
                // Save as Artwork object..

            } catch {
                print("Could not parse as JSON.")
            }
            
        }.resume()
        
        return artworks
    }
    
}
