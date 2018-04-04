//
//  PersistencyManager.swift
//  Gins
//
//  Created by serfusE on 2018/4/4.
//  Copyright © 2018 Dean. All rights reserved.
//

import Foundation

final class PersistencyManager {
    
    // 缓存数据，Controller 的 allTracks 在启动时将尝试调用此处数据
    private var tracks = [Track]()
    
}
