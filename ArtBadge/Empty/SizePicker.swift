import SwiftUI

struct SizePickerView: View {
    @Binding var selectedSize: SizeType
    
    var body: some View {
        Picker("Размер", selection: $selectedSize) {
            Text("Большой").tag(SizeType.large)
            Text("Средний").tag(SizeType.medium)
            Text("Маленький").tag(SizeType.small)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}

