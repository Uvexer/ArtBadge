import SwiftUI

struct ImageEditorView: View {
    let uiImage: UIImage?
    let imageName: String?
    let shape: ShapeType
    let size: CGSize

    @Binding var currentScale: CGFloat
    @Binding var lastScaleValue: CGFloat
    @Binding var offset: CGSize
    @Binding var lastOffset: CGSize

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let uiImage = uiImage {
                    ZoomableImageView(
                        image: Image(uiImage: uiImage),
                        size: size,
                        shape: shape,
                        currentScale: $currentScale,
                        lastScaleValue: $lastScaleValue,
                        offset: $offset,
                        lastOffset: $lastOffset,
                        geometrySize: geometry.size
                    )
                } else if let imageName = imageName {
                    ZoomableImageView(
                        image: Image(imageName),
                        size: size,
                        shape: shape,
                        currentScale: $currentScale,
                        lastScaleValue: $lastScaleValue,
                        offset: $offset,
                        lastOffset: $lastOffset,
                        geometrySize: geometry.size
                    )
                } else {
                    Text("Изображение не доступно")
                        .foregroundColor(.red)
                }

                Image("logo.sun")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.7)
                    .frame(width: size.width * 0.3, height: size.height * 0.3)
                    .position(x: size.width * 0.8, y: size.height * 0.8)
            }
            .frame(width: size.width, height: size.height)
        }
        .frame(width: size.width, height: size.height)
    }
}

