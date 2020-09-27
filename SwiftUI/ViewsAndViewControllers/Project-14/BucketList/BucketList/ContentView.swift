//
//  ContentView.swift
//  BucketList
//
//  Created by QDSG on 2020/9/27.
//

import SwiftUI

struct ContentView: View {
//    let values = [1, 5, 3, 6, 2, 9].sorted()
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister")
    ].sorted()
//    {
//        $0.lastName < $1.lastName
//    }
    
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                let url = getDocumentsDirectory().appendingPathComponent("message.txt")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print("input: \(input)")
                } catch {
                    print("写文件发生错误: \(error.localizedDescription)")
                }
            }
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
