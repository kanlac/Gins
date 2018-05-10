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
    @IBAction func makeRequest(_ sender: Any) {
        queryTextField.resignFirstResponder()
        query = queryTextField.text
        LibraryAPI.shared.fetchArtworks(with: query!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        queryTextField.text = query
        queryTextField.delegate = self
        artworkTableView.dataSource = self
        artworkTableView.delegate = self
        artworkTableView.rowHeight = 85
        artworkTableView.separatorStyle = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateView), name: .artworksFetchedNK, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        LibraryAPI.shared.fetchArtworks(with: query!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showArtworkSegue,
            let destination = segue.destination as? ArtworkSelectionVC,
            let artworkIndex = artworkTableView.indexPathForSelectedRow?.row {
            destination.selectionURLString = artworks[artworkIndex].convertHiRsURLString()
        }
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
        let currentArtwork = artworks[indexPath.row]
        
        var artwork = UIImage()
        if let artworkURL = URL(string: currentArtwork.artworkURLString),
            let artworkData = try? Data(contentsOf: artworkURL) {
            artwork = UIImage(data: artworkData)!
        }
        cell.artworkImageView.image = artwork
        cell.albumTitle.text = currentArtwork.title
        cell.artistTitle.text = currentArtwork.artist
        return cell
    }
    
}

extension PickArtworkVC: UITableViewDelegate {
}

extension PickArtworkVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        makeRequest(self)
        return true
    }
}






