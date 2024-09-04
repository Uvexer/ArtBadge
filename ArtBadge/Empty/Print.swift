import SwiftUI

struct PrintView: View {
    let selectedImage: IdentifiableImage
    let selectedShape: ShapeType
    let selectedSize: SizeType
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            if let uiImage = UIImage(data: selectedImage.imageData) {
                ZStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(selectedShape.shape)
                        .frame(width: selectedShape.frameSize(for: selectedSize).width,
                               height: selectedShape.frameSize(for: selectedSize).height)
                    
                    Image("logo.sun")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.7)
                        .frame(width: selectedShape.frameSize(for: selectedSize).width * 0.3,
                               height: selectedShape.frameSize(for: selectedSize).height * 0.3)
                        .offset(x: 0, y: 0)
                }
                .compositingGroup()
                .frame(width: selectedShape.frameSize(for: selectedSize).width,
                       height: selectedShape.frameSize(for: selectedSize).height)
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
