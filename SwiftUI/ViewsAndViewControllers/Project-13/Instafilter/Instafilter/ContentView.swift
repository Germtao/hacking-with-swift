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
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
    @State private var processedImage: UIImage?
    
    var body: some View {
        let intensity = Binding<Double> {
            filterIntensity
        } set: {
            filterIntensity = $0
            applyProcessing()
        }

        
        return NavigationView {
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
                    Slider(value: intensity)
                }
                .padding(.vertical)
                
                HStack {
                    Button("更换滤镜") {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("保存") {
                        guard let saveImage = processedImage else { return }
                        
                        let saver = ImageSaver()
                        saver.writeToPhotoAlbum(image: saveImage)
                        saver.successHandler = {
                            print("保存照片成功!")
                        }
                        saver.failureHandler = {
                            print("保存照片失败: \($0.localizedDescription)")
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage2, content: {
                ImagePicker(image: $inputImage)
            })
            .actionSheet(isPresented: $showingFilterSheet, content: {
                ActionSheet(title: Text("选择一个滤镜"), buttons: [
                    .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
            })
        }
    }
}

extension ContentView {
    private func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage2()
    }
    
    private func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    private func loadImage2() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
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
