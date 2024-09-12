import SwiftUI

struct PrintView: View {
    let selectedImage: IdentifiableImage
    let selectedShape: ShapeType
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var animateGradient: Bool = false
    private let startColor: Color = .blue
    private let endColor: Color = .green
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }

            VStack {
                if let uiImage = UIImage(data: selectedImage.imageData) {
                    ZStack {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(selectedShape.shape)
                            .frame(width: selectedShape.frameSize().width,
                                   height: selectedShape.frameSize().height)
                        
                        Image("logo.sun")
                            .resizable()
                            .scaledToFit()
                            .opacity(0.7)
                            .frame(width: selectedShape.frameSize().width * 0.3,
                                   height: selectedShape.frameSize().height * 0.3)
                            .offset(x: 0, y: 0)
                    }
                    .compositingGroup()
                    .frame(width: selectedShape.frameSize().width,
                           height: selectedShape.frameSize().height)
                }
                
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Назад")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                    
                    Button(action: {
                        // Логика для печати
                    }) {
                        Text("Печать")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                }
            }
            .padding()
        }
    }
}
