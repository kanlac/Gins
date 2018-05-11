//
//  ViewController.swift
//  Gins
//
//  Created by serfusE on 2018/4/4.
//  Copyright © 2018 Dean. All rights reserved.
//

import UIKit

class tracksTableViewCell: UITableViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitileLabel: UILabel!
}

class ViewController: UIViewController {
    
    var allTracks = [Track]()
    var lyrics = String()
    let urlString = Constants.Last_fm.base_url + Constants.Last_fm.Key.methods + Constants.Last_fm.Value.user_getRecentTracks + Constants.Last_fm.Key.format + Constants.Last_fm.Value.format + Constants.Last_fm.Key.api_key + Constants.Last_fm.Value.api_key + Constants.Last_fm.Key.user + Constants.username
    enum LyricsStatus {
        case loading
        case unavailable
        case loaded
    }
    
    // MARK: Interface Builder
    
    @IBOutlet weak var titleLabel: MarqueeLabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var lyricsTextView: UITextView!
    @IBOutlet weak var latestCover: UIImageView!
    @IBOutlet weak var updateButtonOutlet: UIButton!
    @IBOutlet weak var tracksTableView: UITableView!
    
    @IBAction func updateButton(_ sender: Any) {
        LibraryAPI.shared.requestData(url: urlString)
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.byValue = CGFloat.pi * 4
        rotation.duration = 2
        updateButtonOutlet.layer.add(rotation, forKey: "transform.rotation")
    
    }
    
    // MARK: View Controller Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Lucida Grande", size: 21)!]
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        titleLabel.speed = .rate(50)
        titleLabel.fadeLength = 10
        titleLabel.animationDelay = 5
        
        tracksTableView.delegate = self
        tracksTableView.dataSource = self
        tracksTableView.rowHeight = 60
        tracksTableView.separatorStyle = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTracksView(with:)), name: .updateTracksViewNK, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLyrics(with:)), name: .loadLyricsNK, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(encodeTracks(with:)), name: .UIApplicationWillResignActive, object: nil)
        
        // try cache
        allTracks = LibraryAPI.shared.getTracks()
        if allTracks.count > 0 {
            print("updating for existing data..")
            let latest = allTracks[0]
            DispatchQueue.main.async {
                self.titleLabel.text = latest.title + "   "
                self.artistLabel.text = latest.artist
                self.albumLabel.text = latest.album
                self.lyricsTextView.text = ""
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        LibraryAPI.shared.requestData(url: urlString)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .UIApplicationWillResignActive, object: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let latest = allTracks[0]
        let query = latest.album + " " + latest.artist
        let destinationVC = segue.destination as! PickArtworkVC
        destinationVC.query = query
    }
    
    // MARK: View Controller Methods
    
    func updateViewProperties() {
        
        if allTracks.count > 0 {
            let latest = allTracks[0]
            
            var cover = UIImage()
            if let largeCoverURLString = latest.coverURL[.large], let largeCoverURL = URL(string: largeCoverURLString), let coverData = try? Data(contentsOf: largeCoverURL) {
                cover = UIImage(data: coverData)!
            }
            
            DispatchQueue.main.async {
                self.titleLabel.text = latest.title + "   "
                self.artistLabel.text = latest.artist
                self.albumLabel.text = latest.album
                self.latestCover.image = cover
                
                self.lyricsTextView.text = ""
                
                self.tracksTableView.reloadData()
            }
            
            LibraryAPI.shared.fetchLyrics(title: latest.title, artist: latest.artist)
        }
        
        updateLyricsView(status: .loading)
        
    }
    
    func updateLyricsView(status: LyricsStatus) {
        
        var text = ""
        
        switch status {
        case .loading:
            text = "Loading lyrics.."
        case .loaded:
            text = LibraryAPI.shared.getLyrics()
        case .unavailable:
            text = "Lyrics unavailable😢"
        }
        
        DispatchQueue.main.async {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 7
            let attributes = [NSAttributedStringKey.paragraphStyle : style, NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 19)!]
            self.lyricsTextView.attributedText = NSAttributedString(string: text, attributes:attributes)
        }
    }
    
    // MARK: Notification Methods
    
    @objc func updateLyrics(with notification: Notification) {
        lyrics = LibraryAPI.shared.getLyrics()
        if lyrics == "" {
            updateLyricsView(status: .unavailable)
        } else {
            updateLyricsView(status: .loaded)
        }
    }
    
    // load cache
    @objc func updateTracksView(with notification: Notification) {
        allTracks = LibraryAPI.shared.getTracks()
        updateViewProperties()
    }
    
    @objc func encodeTracks(with notification: Notification) {
        LibraryAPI.shared.encodeTracks()
    }
    
}

// MARK: Extensions

extension ViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTracks.count - 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! tracksTableViewCell
        let currentTrack = allTracks[indexPath.row + 1]
        cell.titleLabel.text = currentTrack.title
        cell.subtitileLabel.text = currentTrack.artist
        
        var cover = UIImage()
        if let coverURLString = currentTrack.coverURL[.medium], let coverURL = URL(string: coverURLString), let coverData = try? Data(contentsOf: coverURL) {
            cover = UIImage(data: coverData)!
        }
        cell.coverImageView.image = cover
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}
















