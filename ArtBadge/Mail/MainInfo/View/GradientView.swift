import SwiftUI

struct BackgroundGradientView: View {
    private let startColor: Color = .blue
    private let endColor: Color = .green
    
    var body: some View {
        LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}
