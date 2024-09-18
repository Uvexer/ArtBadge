import SwiftUI
import UIKit

struct EmptyView: View {
    let selectedImage: IdentifiableImage
    @State private var selectedShape: ShapeType = .circle
    
    @State private var currentScale: CGFloat = 1.0
    @State private var lastScaleValue: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    @State private var animateGradient: Bool = false
    private let startColor: Color = .blue
    private let endColor: Color = .green
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }

            VStack {
                Text("Выбери фигуру")
                    .font(.system(size: 36))
                    .fontWeight(.bold)
                
                if let uiImage = UIImage(data: selectedImage.imageData) {
                    ImageEditorView(
                        uiImage: uiImage,
                        imageName: nil,
                        shape: selectedShape,
                        size: selectedShape.frameSize(),
                        currentScale: $currentScale,
                        lastScaleValue: $lastScaleValue,
                        offset: $offset,
                        lastOffset: $lastOffset
                    )
                } else {
                    Text("Не удалось загрузить изображение")
                        .foregroundColor(.red)
                }

                ShapePickerView(selectedShape: $selectedShape)
                
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Назад")
                            .font(.title)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        printImage()
                    }) {
                        Text("Печать")
                            .font(.title)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .padding()
        }
    }

    private func printImage() {
        guard let uiImage = UIImage(data: selectedImage.imageData),
              let logoImage = UIImage(named: "logo.sun") else {
            print("Не удалось загрузить изображение для печати или логотип")
            return
        }
        
        let printController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.outputType = .general
        printInfo.jobName = "Печать изображения"
        printInfo.orientation = .portrait
        printController.printInfo = printInfo
        
        let imageSize: CGSize
        let isCircle: Bool
        switch selectedShape {
        case .circle:
            let diameter: CGFloat = 1.9685 * 72
            imageSize = CGSize(width: diameter, height: diameter)
            isCircle = true
            
        case .square:
            let width: CGFloat = 2.3622 * 72
            let height: CGFloat = 1.5748 * 72
            imageSize = CGSize(width: width, height: height)
            isCircle = false
            
        case .rectangle:
            let width: CGFloat = 1.9685 * 72
            let height: CGFloat = 3.54331 * 72
            imageSize = CGSize(width: width, height: height)
            isCircle = false
        }
        
        let logoSize = CGSize(width: 50, height: 50)
        
        let printRenderer = UIGraphicsImageRenderer(size: CGSize(width: 595, height: 842))
        
        let imageToPrint = printRenderer.image { context in
            let pageRect = CGRect(x: 0, y: 0, width: 595, height: 842)
            let imageOrigin = CGPoint(x: (pageRect.width - imageSize.width) / 2,
                                      y: (pageRect.height - imageSize.height) / 2)
            
            if isCircle {
                let circlePath = UIBezierPath(ovalIn: CGRect(origin: imageOrigin, size: imageSize))
                circlePath.addClip()
            }
            
            uiImage.draw(in: CGRect(origin: imageOrigin, size: imageSize))
            
            let logoOrigin = CGPoint(x: imageOrigin.x + imageSize.width - logoSize.width - 10,
                                     y: imageOrigin.y + 10)
            logoImage.draw(in: CGRect(origin: logoOrigin, size: logoSize))
        }
        
        printController.printingItem = imageToPrint
        
        printController.present(animated: true, completionHandler: { (printController, completed, error) in
            if !completed, let error = error {
                print("Ошибка печати: \(error.localizedDescription)")
            } else {
                print("Печать завершена успешно")
            }
        })
    }

}

