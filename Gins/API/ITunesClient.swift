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
            if error == nil {

                guard let data = data else {
                    print("No data returned.")
                    return
                }

                var parseResult: [String: AnyObject]

                do {
                    parseResult = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                    print(parseResult)

                } catch {
                    print("Could not parse as JSON.")
                }

            } else {
                print(error ?? "Error (no message)")
            }
        }.resume()
        
        return artworks
    }
    
}
