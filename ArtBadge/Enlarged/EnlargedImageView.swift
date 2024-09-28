import SwiftUI

struct EnlargedImageView: View {
    let uiImage: UIImage?
    let imageName: String?
    
    @Environment(\.dismiss) var dismiss
    @State private var isEmptyViewPresented = false
    @State private var animateGradient: Bool = false
    
    private let startColor: Color = .blue
    private let endColor: Color = .green
    
    var body: some View {
        ZStack {
            AnimatedsGradientView(animateGradient: $animateGradient, startColor: startColor, endColor: endColor)
            VStack {
                ImageDisplayView(uiImage: uiImage, imageName: imageName)
                ActionButtons(dismiss: dismiss, isEmptyViewPresented: $isEmptyViewPresented, uiImage: uiImage, imageName: imageName)
            }
        }
    }
}

