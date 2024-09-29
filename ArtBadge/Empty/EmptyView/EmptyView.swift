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
            LinearGradient(colors: [startColor, endColor],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            .hueRotation(.degrees(animateGradient ? 45 : 0))
            .onAppear {
                withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                    animateGradient.toggle()
                }
            }
            
            VStack {
                HeadersView()
                
                ImageLoaderView(
                    selectedImageData: selectedImage.imageData,
                    selectedShape: $selectedShape,
                    currentScale: $currentScale,
                    lastScaleValue: $lastScaleValue,
                    offset: $offset,
                    lastOffset: $lastOffset
                )
                
                ShapePickerView(selectedShape: $selectedShape)
                
                ButtonsView(
                    dismissAction: { dismiss() },
                    printAction: { printImage() }
                )
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
                    let diameter: CGFloat = 2.165354 * 130
                    imageSize = CGSize(width: diameter, height: diameter)
                    isCircle = true
    
                case .square:
                    let width: CGFloat = 2.362205 * 72
                    let height: CGFloat = 1.574803 * 72
                    imageSize = CGSize(width: width, height: height)
                    isCircle = false
    
                case .rectangle:
                    let width: CGFloat =  3.5433307 * 72
                    let height: CGFloat =  1.968504 * 72
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
    
                    let logoOrigin = CGPoint(x: imageOrigin.x + imageSize.width - logoSize.width - 90,
                                             y: imageOrigin.y + 80)
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
    
    
   
