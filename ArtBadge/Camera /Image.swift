import SwiftUI
import AVFoundation
struct ImageView: View {
    var image: UIImage?

    @State private var isEnlargedImageViewPresented = false
    @State private var selectedImage: IdentifiableUIImage?

    var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .ignoresSafeArea()

                Button("Далее") {
                    selectedImage = IdentifiableUIImage(image: image)
                    isEnlargedImageViewPresented = true
                }
                .font(.system(size: 24))
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .fullScreenCover(item: $selectedImage) { image in
                    EnlargedImageView(selectedImage: image)
                }
            } else {
                Text("No image captured")
                    .foregroundColor(.red)
            }
            Spacer()
        }
    }
}
