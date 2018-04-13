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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    
    
    @IBAction func updateButton(_ sender: Any) {
        print(LibraryAPI.shared.getTracks())
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showLatestTrack(with:)), name: .updateViewNK, object: nil)
        // add observer: lyrics data stored..
        
        updateViewProperties()
        
        let urlString = Constants.Last_fm.base_url + Constants.Last_fm.Key.methods + Constants.Last_fm.Value.user_getRecentTracks + Constants.Last_fm.Key.format + Constants.Last_fm.Value.format + Constants.Last_fm.Key.api_key + Constants.Last_fm.Value.api_key + Constants.Last_fm.Key.user + Constants.username
        LibraryAPI.shared.requestData(url: urlString)
        
    }
    
    func updateViewProperties() {
        
        allTracks = LibraryAPI.shared.getTracks()
        
        // latest
        if allTracks.count > 0 {
            let latest = allTracks[0]
            DispatchQueue.main.async {
                self.titleLabel.text = latest.title
                self.artistLabel.text = latest.artist
                self.albumLabel.text = latest.album
            }
            
        }
        
        // table view
        
        
    }
    
    // userInfo had no use, consider delegate instead?
    @objc func showLatestTrack(with notification: Notification) {
        updateViewProperties()
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
