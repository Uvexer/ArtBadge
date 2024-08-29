import SwiftUI

struct EnlargedImageView: View {
    let imageName: String
    @Binding var isImageSelected: Bool
    
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
                    
                    NavigationLink(destination: EmptyView()) {
                        Text("Выбрать")
                            .font(.system(size: 24))
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
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
