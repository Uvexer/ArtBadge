import SwiftUI

struct ImageEditorView: View {
    let imageName: String
    let shape: ShapeType
    let size: CGSize
    
    @Binding var currentScale: CGFloat
    @Binding var lastScaleValue: CGFloat
    @Binding var offset: CGSize
    @Binding var lastOffset: CGSize
    
    var body: some View {
        GeometryReader { geometry in
            Image(imageName)
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
                            self.adjustOffset(for: geometry.size, in: size)
                        }
                        .simultaneously(
                            with: DragGesture()
                                .onChanged { value in
                                    self.offset = CGSize(
                                        width: self.lastOffset.width + value.translation.width,
                                        height: self.lastOffset.height + value.translation.height
                                    )
                                }
                                .onEnded { value in
                                    self.lastOffset = self.offset
                                    self.adjustOffset(for: geometry.size, in: size)
                                }
                        )
                )
                .frame(width: size.width, height: size.height)
                .clipShape(shape.shape)
                .overlay(shape.shape.stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding()
        }
        .frame(width: size.width, height: size.height)
    }
    
    private func adjustOffset(for parentSize: CGSize, in shapeSize: CGSize) {
        let scaledWidth = shapeSize.width * currentScale
        let scaledHeight = shapeSize.height * currentScale
        
        let halfImageWidth = scaledWidth / 2
        let halfImageHeight = scaledHeight / 2
        
        let minXOffset = -halfImageWidth + parentSize.width / 2
        let maxXOffset = halfImageWidth - parentSize.width / 2
        let minYOffset = -halfImageHeight + parentSize.height / 2
        let maxYOffset = halfImageHeight - parentSize.height / 2
        
        offset.width = min(max(lastOffset.width, minXOffset), maxXOffset)
        offset.height = min(max(lastOffset.height, minYOffset), maxYOffset)
        
        lastOffset = offset
    }
}

