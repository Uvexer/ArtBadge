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
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .onAppear {
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }

            VStack {
                if let uiImage = uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 500, height: 500)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .padding()
                } else if let imageName = imageName {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 500, height: 500)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .padding()
                } else {
                    Text("Изображение не найдено")
                        .foregroundColor(.red)
                }

                HStack {
                    Button("Назад") {
                        dismiss()
                    }
                    .font(.system(size: 24))
                    .padding()
                    .background(Color.gray.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Spacer()
                    Button("Далее") {
                        isEmptyViewPresented = true
                    }
                    .font(.system(size: 24))
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .fullScreenCover(isPresented: $isEmptyViewPresented) {
                        if let uiImage = uiImage, let imageData = uiImage.jpegData(compressionQuality: 1.0) {
                            let identifiableImage = IdentifiableImage(id: UUID(), name: imageName ?? "Selected Image", imageData: imageData)
                            EmptyView(selectedImage: identifiableImage)
                        } else {
                            Text("Не удалось загрузить изображение")
                        }
                    }
                }
                .padding()
            }
        }
    }
}
