//
//  User.swift
//  HotProspects
//
//  Created by QDSG on 2020/10/9.
//

import Foundation

/// 使用环境对象在两个视图之间共享数据
class User: ObservableObject {
    @Published var name = "Taylor Swift"
}
