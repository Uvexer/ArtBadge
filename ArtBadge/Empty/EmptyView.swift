
import SwiftUI

struct EmptyView: View {
    let selectedImage: IdentifiableImage
    @State private var selectedShape: ShapeType = .circle
    @State private var selectedSize: SizeType = .medium
    
    @State private var currentScale: CGFloat = 1.0
    @State private var lastScaleValue: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    @State private var isPrintViewPresented: Bool = false
    
    var body: some View {
        VStack {
            Text("Выбери фигуру и размер")
                .font(.system(size: 36))
                .fontWeight(.bold)
            
            if let uiImage = UIImage(data: selectedImage.imageData) {
                ImageEditorView(
                    uiImage: uiImage,
                    imageName: nil,
                    shape: selectedShape,
                    size: selectedShape.frameSize(for: selectedSize),
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
            SizePickerView(selectedSize: $selectedSize)
            Button(action: {
                isPrintViewPresented = true
            }) {
                Text("Печать")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
            .fullScreenCover(isPresented: $isPrintViewPresented) {
                PrintView(selectedImage: selectedImage, selectedShape: selectedShape, selectedSize: selectedSize)
            }
        }
        .padding()
    }
}