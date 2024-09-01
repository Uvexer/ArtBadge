import SwiftUI

struct PrintView: View {
    let selectedImage: IdentifiableImage
    let selectedShape: ShapeType
    let selectedSize: SizeType
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
        
            if let uiImage = UIImage(data: selectedImage.imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
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
