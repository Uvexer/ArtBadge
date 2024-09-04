import SwiftUI

struct ShapePickerView: View {
    @Binding var selectedShape: ShapeType
    
    var body: some View {
        Picker("Фигура", selection: $selectedShape) {
            Text("Круг").tag(ShapeType.circle)
            Text("Квадрат").tag(ShapeType.square)
            Text("Прямоугольник").tag(ShapeType.rectangle)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

