import SwiftUI

struct EnlargedImageView: View {
    let uiImage: UIImage?
    let imageName: String?

    @Environment(\.dismiss) var dismiss
    @State private var isEmptyViewPresented = false 
    var body: some View {
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
