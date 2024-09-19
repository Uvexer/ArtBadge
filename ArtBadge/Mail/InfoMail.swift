import SwiftUI

struct InfoMailView: View {
    @State private var animateGradient: Bool = false
    private let startColor: Color = .blue
    private let endColor: Color = .green
    private let textMail: String = "ArtBadge21@gmail.com"
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .hueRotation(.degrees(animateGradient ? 45 : 0))

            VStack(spacing: 100) {
                Text("Отправьте свое фото на почту\n \(textMail)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                HStack(spacing:200) {
                    Button(action: {
                        withAnimation {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Назад")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 150, height: 50)
                            .background(Color.blue.opacity(0.9))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
           
                    NavigationLink(destination: InfoNextMailView()) {
                        Text("Далее")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 150, height: 50)
                            .background(Color.blue.opacity(0.9))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
              
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

#Preview {
    InfoMailView()
}

