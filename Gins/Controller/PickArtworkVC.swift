//
//  PickArtworkVC.swift
//  Gins
//
//  Created by serfusE on 2018/5/1.
//  Copyright © 2018 Dean. All rights reserved.
//

import Foundation
import UIKit

class ArtworkTableViewCell: UITableViewCell {
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var artistTitle: UILabel!
}

class PickArtworkVC: UIViewController {
    
    var query: String?
    var artworks = [Artwork]()
    
    @IBOutlet weak var artworkTableView: UITableView!
    @IBOutlet weak var queryTextField: UITextField!
    
    @IBAction func DismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queryTextField.text = query
        LibraryAPI.shared.fetchArtworks(with: query!)
        artworkTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateView), name: .artworksFetchedNK, object: nil)
    }
    
    @objc func updateView() {
        artworks = LibraryAPI.shared.getArtworks()
        
        DispatchQueue.main.async {
            self.artworkTableView.reloadData()
        }
    }
    
}

extension PickArtworkVC: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artworks.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.artworkCellIdentifier, for: indexPath) as! ArtworkTableViewCell
        cell.albumTitle.text = artworks[indexPath.row].title
        cell.artistTitle.text = artworks[indexPath.row].artist
        return cell
    }
    
}
