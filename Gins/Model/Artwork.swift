//
//  Artwork.swift
//  Gins
//
//  Created by serfusE on 2018/5/1.
//  Copyright © 2018 Dean. All rights reserved.
//

import Foundation
import UIKit

struct Artwork {
    
    let title: String
    let artist: String
    let artworkURLString: String
    
    func convertHiRsURLString() -> String {
        return artworkURLString.replacingOccurrences(of: "100x100", with: "1800x1800")
    }
    
}
