//
//  ViewController.swift
//  Gins
//
//  Created by serfusE on 2018/4/4.
//  Copyright © 2018 Dean. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var allTracks = [Track]()
    var lyrics = String()
    let urlString = Constants.Last_fm.base_url + Constants.Last_fm.Key.methods + Constants.Last_fm.Value.user_getRecentTracks + Constants.Last_fm.Key.format + Constants.Last_fm.Value.format + Constants.Last_fm.Key.api_key + Constants.Last_fm.Value.api_key + Constants.Last_fm.Key.user + Constants.username
    
    @IBOutlet weak var titleLabel: MarqueeLabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var lyricsTextView: UITextView!
    @IBOutlet weak var latestCover: UIImageView!
    
    @IBAction func updateButton(_ sender: Any) {
        LibraryAPI.shared.requestData(url: urlString)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        titleLabel.speed = .rate(50)
        titleLabel.fadeLength = 10
        titleLabel.animationDelay = 5
        
        NotificationCenter.default.addObserver(self, selector: #selector(showLatestTrack(with:)), name: .updateTracksViewNK, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLyrics(with:)), name: .loadLyricsNK, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(encodeTracks(with:)), name: .UIApplicationWillResignActive, object: nil)
        
        LibraryAPI.shared.requestData(url: urlString)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .UIApplicationWillResignActive, object: nil)
    }
    
    func updateViewProperties() {
        
        if allTracks.count > 0 {
            let latest = allTracks[0]
            
            var cover = UIImage()
            if let mediumCoverURLString = latest.coverURL[.medium], let mediumCoverURL = URL(string: mediumCoverURLString), let coverData = try? Data(contentsOf: mediumCoverURL) {
                cover = UIImage(data: coverData)!
            }
            
            DispatchQueue.main.async {
                self.titleLabel.text = latest.title + "   "
                self.artistLabel.text = latest.artist
                self.albumLabel.text = latest.album
                self.lyricsTextView.text = ""
                self.latestCover.image = cover
            }
            
            LibraryAPI.shared.fetchLyrics(title: latest.title, artist: latest.artist)
        }
        
        // table view
        
        
    }
    
    @objc func updateLyrics(with notification: Notification) {
        lyrics = LibraryAPI.shared.getLyrics()
        DispatchQueue.main.async {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 7
            let attributes = [NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 19)!]
            self.lyricsTextView.attributedText = NSAttributedString(string: self.lyrics, attributes:attributes)
        }
    }
    
    // userInfo had no use, consider delegate instead?
    @objc func showLatestTrack(with notification: Notification) {
        allTracks = LibraryAPI.shared.getTracks()
        updateViewProperties()
    }
    
    @objc func encodeTracks(with notification: Notification) {
        LibraryAPI.shared.encodeTracks()
    }
    
}

extension ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    
}
