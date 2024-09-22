import SwiftUI

struct ImageLoaderView: View {
    let selectedImageData: Data
    @Binding var selectedShape: ShapeType
    @Binding var currentScale: CGFloat
    @Binding var lastScaleValue: CGFloat
    @Binding var offset: CGSize
    @Binding var lastOffset: CGSize

    var body: some View {
        if let uiImage = UIImage(data: selectedImageData) {
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
            .offset(x: -15, y: -15)
        } else {
            Text("Не удалось загрузить изображение")
                .foregroundColor(.red)
        }
    }
}

