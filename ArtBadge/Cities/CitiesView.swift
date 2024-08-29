import SwiftUI

struct IdentifiableImage: Identifiable {
    let id = UUID()
    let name: String
}

struct CitiesView: View {
    let images = ["city1", "city2", "city3", "city4"]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var selectedImage: IdentifiableImage? = nil
    @State private var isImageSelected: Bool = false
    
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
                                selectedImage = IdentifiableImage(name: imageName)
                            }
                    }
                }
                .padding()
            }
        }
        .fullScreenCover(item: $selectedImage) { image in
            EnlargedImageView(imageName: image.name, isImageSelected: $isImageSelected, selectedImage: $selectedImage)
        }
        .navigationDestination(isPresented: $isImageSelected) {
            if let selectedImage = selectedImage {
                EmptyView(selectedImage: selectedImage)
            }
        }
    }
}


#Preview {
    CitiesView()
}

