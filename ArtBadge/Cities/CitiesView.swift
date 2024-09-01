import SwiftUI

struct IdentifiableImage: Identifiable {
    let id: UUID
    let name: String
    let imageData: Data
}

struct CitiesView: View {
    let images = ["city1", "city2", "city3", "city4"]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var selectedImage: IdentifiableImage? = nil
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Выбери фотографию")
                    .font(.system(size: 36))
                    .padding(.top)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(images, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .padding()
                            .onTapGesture {
                                if let uiImage = UIImage(named: imageName), let imageData = uiImage.jpegData(compressionQuality: 1.0) {
                                    selectedImage = IdentifiableImage(id: UUID(), name: imageName, imageData: imageData)
                                }
                            }
                    }
                }
                .padding()
            }
        }
        .fullScreenCover(item: $selectedImage) { image in
            PrintView(selectedImage: image, selectedShape: .rectangle, selectedSize: .medium)
        }
    }
}

