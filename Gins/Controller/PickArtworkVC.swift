//
//  PickArtworkVC.swift
//  Gins
//
//  Created by serfusE on 2018/5/1.
//  Copyright © 2018 Dean. All rights reserved.
//

import Foundation
import UIKit

class PickArtworkVC: UIViewController {
    
    var query: String?
    
    @IBOutlet weak var queryTextField: UITextField!
    @IBAction func DismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        queryTextField.text = query
        LibraryAPI.shared.fetchArtworks(with: query!)
    }
    
}
