//
//  ContentView.swift
//  BucketList
//
//  Created by QDSG on 2020/9/27.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if self.isUnlocked {
                Text("已解锁")
            } else {
                Text("已锁定")
            }
        }
        .onAppear(perform: authenticate)
    }
}

extension ContentView {
    /// FaceID认证
    private func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // 检查生物识别认证是否可用
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "我们需要解锁您的数据"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                // 身份验证已完成
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        print("认证失败: \(error?.localizedDescription ?? "Unknown error.")")
                    }
                }
            }
        } else {
            print("没有生物识别功能")
        }
    }
    
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
