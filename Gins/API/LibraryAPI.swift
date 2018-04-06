//
//  LibraryAPI.swift
//  Gins
//
//  Created by serfusE on 2018/4/4.
//  Copyright © 2018 Dean. All rights reserved.
//

import Foundation

final class LibraryAPI {
    
    static let shared = LibraryAPI()
    
    static let httpsClient = HTTPSClient()
    static let persistencyManager = PersistencyManager()
    
    // add notification observer..
    // init {}
}
