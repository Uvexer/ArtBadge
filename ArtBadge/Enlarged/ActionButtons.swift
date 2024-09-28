import SwiftUI


struct ActionButtons: View {
    var dismiss: DismissAction
    @Binding var isEmptyViewPresented: Bool
    let uiImage: UIImage?
    let imageName: String?
    
    var body: some View {
        HStack(spacing: 200) {
            Button("Назад") {
                dismiss()
            }
            .font(.title)
            .foregroundColor(.white)
            .frame(width: 150, height: 50)
            .background(Color.blue.opacity(0.9))
            .cornerRadius(10)
            .shadow(radius: 5)
            
            Button("Далее") {
                isEmptyViewPresented = true
            }
            .font(.title)
            .foregroundColor(.white)
            .frame(width: 150, height: 50)
            .background(Color.blue.opacity(0.9))
            .cornerRadius(10)
            .shadow(radius: 5)
            .fullScreenCover(isPresented: $isEmptyViewPresented) {
                if let uiImage = uiImage, let imageData = uiImage.jpegData(compressionQuality: 1.0) {
                    let identifiableImage = IdentifiableImage(id: UUID(), name: imageName ?? "Selected Image", imageData: imageData)
                    EmptyView(selectedImage: identifiableImage)
                } else {
                    Text("Не удалось загрузить изображение")
                }
            }
        }
        .padding(.horizontal, 20)
    }
}


