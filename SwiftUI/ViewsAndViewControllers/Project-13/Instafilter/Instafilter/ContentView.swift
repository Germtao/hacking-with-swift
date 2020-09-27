//
//  ContentView.swift
//  Instafilter
//
//  Created by QDSG on 2020/9/25.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    
    /// 滤镜的强度: 0.0~1.0
    @State private var filterIntensity = 0.5
    
    @State private var showingImagePicker = false
    
    @State private var inputImage: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("点击选择一张照片")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                HStack {
                    Text("滤镜强度")
                    Slider(value: $filterIntensity)
                }
                .padding(.vertical)
                
                HStack {
                    Button("更换滤镜") {
                        // change filter
                    }
                    
                    Spacer()
                    
                    Button("保存") {
                        // save the picture
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage2, content: {
                ImagePicker(image: $inputImage)
            })
        }
    }
}

extension ContentView {
    private func loadImage2() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    private func loadImage() {
        guard let inputImage = UIImage(named: "Example") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
//        let currentFilter = CIFilter.sepiaTone() // 棕褐色
//        let currentFilter = CIFilter.pixellate() // 像素化
//        let currentFilter = CIFilter.crystallize() // 水晶效果
        
//        currentFilter.inputImage = beginImage
//        currentFilter.intensity = 1 // 深褐色效果的强度 0-原始图像和1-棕褐色
//        currentFilter.scale = 100 // 像素
        
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//        currentFilter.radius = 200 // 水晶
        
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(2000, forKey: kCIInputRadiusKey)
        currentFilter.setValue(
            CIVector(x: inputImage.size.width / 2,
                     y: inputImage.size.height / 2),
            forKey: kCIInputCenterKey
        )
        
        // 获取CIImage
        guard let outputImage = currentFilter.outputImage else { return }
        
        // 从CIImage获取CGImage
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            // 转换为 UIImage
            let uiImage = UIImage(cgImage: cgImage)
            
            // 并将其转换为SwiftUI图像
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
