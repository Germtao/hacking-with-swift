//
//  ContentView.swift
//  BucketList
//
//  Created by QDSG on 2020/9/27.
//

import SwiftUI

struct ContentView: View {
    
    var loadingState = LoadingState.loading
    
    var body: some View {
        MapView()
            .edgesIgnoringSafeArea(.all)
    }
}

extension ContentView {
    private func getDocumentsDirectory() -> URL {
        // 查找该用户的所有可能的文档目录
        let path = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )
        // 只需发回第一个，应该是唯一的一个
        return path[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
