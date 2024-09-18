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
        guard let uiImage = UIImage(data: selectedImage.imageData) else {
            print("Не удалось загрузить изображение для печати")
            return
        }
        
        let printController = UIPrintInteractionController.shared
        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.outputType = .general
        printInfo.jobName = "Печать изображения"
        printInfo.orientation = .portrait 
        printController.printInfo = printInfo
        
        printController.printingItem = uiImage
        
        printController.present(animated: true, completionHandler: { (printController, completed, error) in
            if !completed, let error = error {
                print("Ошибка печати: \(error.localizedDescription)")
            } else {
                print("Печать завершена успешно")
            }
        })
    }
}

