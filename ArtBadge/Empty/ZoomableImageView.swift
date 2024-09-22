import SwiftUI

struct ZoomableImageView: View {
    let image: Image
    let size: CGSize
    let shape: ShapeType

    @Binding var currentScale: CGFloat
    @Binding var lastScaleValue: CGFloat
    @Binding var offset: CGSize
    @Binding var lastOffset: CGSize

    var geometrySize: CGSize

    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .scaleEffect(currentScale)
            .offset(x: offset.width, y: offset.height)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        let delta = value / self.lastScaleValue
                        self.lastScaleValue = value
                        self.currentScale *= delta
                    }
                    .onEnded { _ in
                        self.lastScaleValue = 1.0
                        self.adjustOffset()
                    }
                    .simultaneously(
                        with: DragGesture()
                            .onChanged { value in
                                self.offset = CGSize(
                                    width: self.lastOffset.width + value.translation.width,
                                    height: self.lastOffset.height + value.translation.height
                                )
                            }
                            .onEnded { _ in
                                self.lastOffset = self.offset
                                self.adjustOffset()
                            }
                    )
            )
            .frame(width: size.width, height: size.height)
            .clipShape(shape.shape)
            .overlay(shape.shape.stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .padding()
    }

    private func adjustOffset() {
        let scaledWidth = size.width * currentScale
        let scaledHeight = size.height * currentScale

        let halfImageWidth = scaledWidth / 2
        let halfImageHeight = scaledHeight / 2

        let minXOffset = -halfImageWidth + geometrySize.width / 2
        let maxXOffset = halfImageWidth - geometrySize.width / 2
        let minYOffset = -halfImageHeight + geometrySize.height / 2
        let maxYOffset = halfImageHeight - geometrySize.height / 2

        offset.width = min(max(lastOffset.width, minXOffset), maxXOffset)
        offset.height = min(max(lastOffset.height, minYOffset), maxYOffset)

        lastOffset = offset
    }
}

