//
//  ContentView.swift
//  BucketList
//
//  Created by QDSG on 2020/9/27.
//

import SwiftUI
import LocalAuthentication
import MapKit

struct ContentView: View {
    
    @State private var isUnlocked = false
    
    /// 中心坐标
    @State private var centerCoordinate = CLLocationCoordinate2D()
    
    @State private var locations = [CodableMKPointAnnotation]()
    
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {

            if isUnlocked {
                MapView(centerCoordinate: $centerCoordinate,
                        annotations: locations,
                        selectedPlace: $selectedPlace,
                        showingPlaceDetails: $showingPlaceDetails)
                    .edgesIgnoringSafeArea(.all)
                
                Circle()
                    .fill(Color.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            let newLocation = CodableMKPointAnnotation()
                            newLocation.coordinate = self.centerCoordinate
                            self.locations.append(newLocation)
                            
                            self.selectedPlace = newLocation
                            self.showingEditScreen = true
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                    }
                }
            } else {
                Button("解锁访问位置") {
                    authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .onAppear(perform: loadData)
        .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "未知"), message: Text(selectedPlace?.subtitle ?? "未找到位置信息"), primaryButton: .default(Text("确定")), secondaryButton: .default(Text("编辑"), action: {
                self.showingEditScreen = true
            }))
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
    }
}

extension ContentView {
    private func loadData() {
        let fileName = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try Data(contentsOf: fileName)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("无法加载保存的数据.")
        }
    }
    
    private func saveData() {
        let fileName = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        
        do {
            let data = try JSONEncoder().encode(locations)
            // 确保文件以强加密方式存储: .completeFileProtection
            try data.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("无法保存数据.")
        }
    }
    
    /// FaceID认证
    private func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // 检查生物识别认证是否可用
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "请验证您的身份以解锁您的位置"
            
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
