//
//  ArtworkSelectionVC.swift
//  Gins
//
//  Created by serfusE on 2018/5/9.
//  Copyright © 2018 Dean. All rights reserved.
//

import UIKit

class ArtworkSelectionVC: UIViewController {
    
    var artworkIndex = Int()

    @IBOutlet weak var selectionImageView: UIImageView!
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
