import SwiftUI

struct EmptyView: View {
    let selectedImage: IdentifiableImage
    @State private var selectedShape: ShapeType = .circle
    @State private var selectedSize: SizeType = .medium
    
    @State private var currentScale: CGFloat = 1.0
    @State private var lastScaleValue: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        VStack {
            let shape = selectedShape.shape
            let size = selectedShape.frameSize(for: selectedSize)
            
            Text("Выбери фигуру и размер")
                .font(.system(size: 36))
                .fontWeight(.bold)
            
            GeometryReader { geometry in
                Image(selectedImage.name)
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
                    .clipShape(shape)
                    .overlay(shape.stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding()
            }
            .frame(width: size.width, height: size.height)
            
            Picker("Фигура", selection: $selectedShape) {
                Text("Круг").tag(ShapeType.circle)
                Text("Квадрат").tag(ShapeType.square)
                Text("Прямоугольник").tag(ShapeType.rectangle)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Picker("Размер", selection: $selectedSize) {
                Text("Большой").tag(SizeType.large)
                Text("Средний").tag(SizeType.medium)
                Text("Маленький").tag(SizeType.small)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
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

#Preview {
    EmptyView(selectedImage: IdentifiableImage(name: "city1"))
}

