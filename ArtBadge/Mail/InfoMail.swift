import SwiftUI

struct InfoMailView: View {
    @State private var animateGradient : Bool = false
    private let startColor : Color = .blue
    private let endColor : Color = .green
    private let textMail :String = "ArtBadge21@gmail.com"
    var body: some View {
        ZStack{
           
                LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
                    .onAppear {
                        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
            
        
            VStack(spacing:100) {
                Text("Информация")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .offset(y: -200)
               
                    Text("Отправьте свое фото на почту\n \(textMail)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
              
                NavigationLink(destination: InfoNextMailView()) {
                    Text("Далее")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
            
        }
    }
    
    
}

#Preview{
    InfoMailView()
}
