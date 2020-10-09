//
//  DelayedUpdater.swift
//  HotProspects
//
//  Created by QDSG on 2020/10/9.
//

import Foundation

class DelayedUpdater: ObservableObject {
    /// 自动
//    @Published var value = 0
    
    /// 手动
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}
