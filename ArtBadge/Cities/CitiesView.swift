import SwiftUI

struct IdentifiableImage: Identifiable {
    let id: UUID
    let name: String
    let imageData: Data
    
    init(id: UUID = UUID(), name: String, imageData: Data) {
        self.id = id
        self.name = name
        self.imageData = imageData
    }
}

struct CitiesView: View {
    let images = ["city1", "city2", "city3", "city4"]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var selectedImage: IdentifiableImage? = nil
    @State private var animateGradient : Bool = false
    private let startColor: Color = .blue
    private let endColor: Color = .green
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack {
                Text("Выбери фотографию")
                    .font(.largeTitle)
                    .fontWeight(.bold)
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
                                    selectedImage = IdentifiableImage(name: imageName, imageData: imageData)
                                }
                            }
                    }
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("назад")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(Color.blue.opacity(0.9))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.bottom, 30)
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .hueRotation(.degrees(animateGradient ? 45 : 0)))
        .fullScreenCover(item: $selectedImage) { image in
            EnlargedImageView(uiImage: UIImage(data: image.imageData), imageName: image.name)
        }
    }
}

#Preview {
    CitiesView()
}

