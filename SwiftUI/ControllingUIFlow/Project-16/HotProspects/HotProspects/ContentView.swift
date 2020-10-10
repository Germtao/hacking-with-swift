//
//  ContentView.swift
//  HotProspects
//
//  Created by QDSG on 2020/10/9.
//

import SwiftUI

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

struct ContentView: View {
    @ObservedObject var updater = DelayedUpdater()
    
    @State private var backgroundColor = Color.red
    @State private var selectedTag = 0
    
    var body: some View {
        VStack {
            Text("Hello World!")
                .padding()
                .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu(menuItems: /*@START_MENU_TOKEN@*/{
                    Button(action: {
                        self.backgroundColor = .red
                        self.selectedTag = 0
                    }, label: {
                        Text("Red")
                        if self.selectedTag == 0 {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.red)
                        }
                    })
                    .tag(0)
                    
                    Button(action: {
                        self.backgroundColor = .green
                        self.selectedTag = 1
                    }, label: {
                        Text("Green")
                        if self.selectedTag == 1 {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.red)
                        }
                    })
                    .tag(1)
                    
                    Button(action: {
                        self.backgroundColor = .blue
                        self.selectedTag = 2
                    }, label: {
                        Text("Blue")
                        if self.selectedTag == 2 {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.red)
                        }
                    })
                    .tag(2)
                }/*@END_MENU_TOKEN@*/)
        }
    }
    
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
