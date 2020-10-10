//
//  ContentView.swift
//  HotProspects
//
//  Created by QDSG on 2020/10/9.
//

import SwiftUI
import UserNotifications
import SamplePackage

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

struct ContentView: View {
    
    var prospects = Prospects()
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("所有人")
                }
            
            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("最近联系")
                }
            
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("未联系")
                }
            
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("我")
                }
        }
        .environmentObject(prospects)
    }
    
    /// MARK - SPM
//    let possibleNumbers = Array(1...60)
//    var results: String {
//        let selected = possibleNumbers.random(7).sorted()
//        let strings = selected.map(String.init)
//        return strings.joined(separator: ", ")
//    }
//    var body: some View {
//        Text(results)
//    }
    
    /// MARK - 本地通知
//    var body: some View {
//        VStack {
//            Button("Request Permission") {
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (success, error) in
//                    if success {
//                        print("All set!")
//                    } else if let error = error {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//
//            Button("Schedule Notification") {
//                let content = UNMutableNotificationContent()
//                content.title = "Feed the cat"
//                content.subtitle = "It looks hungry"
//                content.sound = UNNotificationSound.default
//
//                // 从现在起5秒钟显示此通知
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//                // 选择一个随机标识符
//                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                UNUserNotificationCenter.current().add(request)
//            }
//        }
//    }
    
    /// MARK - 上下文菜单
//    @State private var backgroundColor = Color.red
//    @State private var selectedTag = 0
//
//    var body: some View {
//        VStack {
//            Text("Hello World!")
//                .padding()
//                .background(backgroundColor)
//
//            Text("Change Color")
//                .padding()
//                .contextMenu(menuItems: /*@START_MENU_TOKEN@*/{
//                    Button(action: {
//                        self.backgroundColor = .red
//                        self.selectedTag = 0
//                    }, label: {
//                        Text("Red")
//                        if self.selectedTag == 0 {
//                            Image(systemName: "checkmark.circle.fill")
//                                .foregroundColor(.red)
//                        }
//                    })
//                    .tag(0)
//
//                    Button(action: {
//                        self.backgroundColor = .green
//                        self.selectedTag = 1
//                    }, label: {
//                        Text("Green")
//                        if self.selectedTag == 1 {
//                            Image(systemName: "checkmark.circle.fill")
//                                .foregroundColor(.red)
//                        }
//                    })
//                    .tag(1)
//
//                    Button(action: {
//                        self.backgroundColor = .blue
//                        self.selectedTag = 2
//                    }, label: {
//                        Text("Blue")
//                        if self.selectedTag == 2 {
//                            Image(systemName: "checkmark.circle.fill")
//                                .foregroundColor(.red)
//                        }
//                    })
//                    .tag(2)
//                }/*@END_MENU_TOKEN@*/)
//        }
//    }
    
//    @ObservedObject var updater = DelayedUpdater()
//
//    var body: some View {
//        Image("example")
//            .interpolation(.none)
//            .resizable()
//            .scaledToFit()
//            .frame(maxHeight: .infinity)
//            .background(Color.black)
//            .edgesIgnoringSafeArea(.all)
//    }
    
//    var body: some View {
//        Text("value is: \(updater.value)")
//    }
    
//    var body: some View {
//        Text("Hello World")
//            .onAppear {
//                self.fetchData(from: "https://www.apple.com") { result in
//                    switch result {
//                    case .success(let str):
//                        print("success: \(str)")
//                    case .failure(let error):
//                        switch error {
//                        case .badURL:
//                            print("Bad URL.")
//                        case .requestFailed:
//                            print("Request Failed.")
//                        case .unknown:
//                            print("Unknown error.")
//                        }
//                    }
//                }
//            }
//    }
}

extension ContentView {
    private func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    completion(.failure(.requestFailed))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
