//
//  MusixmatchClient.swift
//  Gins
//
//  Created by serfusE on 2018/4/6.
//  Copyright © 2018 Dean. All rights reserved.
//

import Foundation

class MusixmatchClient {
    
    func fetchLyrics(title: String, artist: String) {
        let requestString = Constants.Musixmatch.base_url + Constants.Musixmatch.Method.get_lyrics + Constants.Musixmatch.Key.format + Constants.Musixmatch.Value.format + Constants.Musixmatch.Key.callback + Constants.Musixmatch.Value.callback + Constants.Musixmatch.Key.track_name + title + Constants.Musixmatch.Key.artist_name + artist + Constants.Musixmatch.Key.api_key + Constants.Musixmatch.Value.api_key
        let encodedRequestString = requestString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let request = URL(string: encodedRequestString)!

        var finalLyrics: String?

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {

                guard let data = data else {
                    print("No data returned.")
                    return
                }

                let parseResult: [String: AnyObject]!

                do {
                    parseResult = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]

                    guard let message = parseResult["message"] as? [String: AnyObject] else {
                        print("Get message error.")
                        return
                    }
                    guard let body = message["body"] as? [String: AnyObject] else {
                        print("body error.")
                        return
                    }
                    guard let lyricsDic = body["lyrics"] as? [String: AnyObject] else {
                        print("lyricsDic error.")
                        return
                    }
                    guard let lyrics_body = lyricsDic["lyrics_body"] as? String else {
                        print("lyrics_body error.")
                        return
                    }

                    finalLyrics = lyrics_body.replacingOccurrences(of: ",\n", with: "\n").replacingOccurrences(of: ", ", with: "\n").replacingOccurrences(of: ".\n", with: "\n")
                    LibraryAPI.shared.saveLyrics(finalLyrics!)
                    
                } catch {
                    print("could not parse as JSON")
                }


            } else {
                print(error ?? "Error (no message)")
            }
            }.resume()

    }
    
}
