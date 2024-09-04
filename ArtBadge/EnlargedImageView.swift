import SwiftUI

struct EnlargedImageView: View {
    let uiImage: UIImage?
    let imageName: String?
    
    @State private var isEmptyViewPresented = false

    init(selectedImage: IdentifiableUIImage) {
        self.uiImage = selectedImage.image
        self.imageName = nil
    }

    init(selectedImage: IdentifiableImage) {
        self.uiImage = UIImage(data: selectedImage.imageData)
        self.imageName = selectedImage.name
    }
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
            } else if let imageName = imageName {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
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
                    }
                }
            }
            .padding()
        }
    }
}
