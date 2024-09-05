import SwiftUI

struct ContentView: View {
    
    @State private var animateGradient : Bool = false
    private let startColor: Color = .blue
        private let endColor: Color = .green
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HeaderView(text: "Давай выберем папку")
                    .offset(y: -100)
                
                FolderButtons()
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
                    .onAppear {
                        withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

