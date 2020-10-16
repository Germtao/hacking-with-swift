//
//  Favorites.swift
//  SnowSeeker
//
//  Created by QDSG on 2020/10/16.
//

import SwiftUI

class Favorites: ObservableObject {
    /// 用户喜欢的度假胜地
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    init() {
        self.resorts = []
    }
    
    /// 如果我们的集合包含此度假村，则返回true
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    /// 将度假村添加到我们的集合中，更新所有视图，并保存更改
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        
        save()
    }
    
    /// 从我们的集合中删除该度假村，更新所有视图，并保存更改
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        
        save()
    }
    
    func save() {
        
    }
}
