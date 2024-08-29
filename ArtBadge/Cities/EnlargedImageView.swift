import SwiftUI

struct EnlargedImageView: View {
    let imageName: String
    @Binding var isImageSelected: Bool
    @Binding var selectedImage: IdentifiableImage?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .edgesIgnoringSafeArea(.all)
                
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
                    
                    if let image = selectedImage {
                        NavigationLink(destination: EmptyView(selectedImage: image)) {
                            Text("Выбрать")
                                .font(.system(size: 24))
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    } else {
                        Text("Выбрать")
                            .font(.system(size: 24))
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .opacity(0.5) 
                    }
                }
                .padding()
            }
        }
    }
}


#Preview {
    CitiesView()
}
