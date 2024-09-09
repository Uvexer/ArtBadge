import SwiftUI

struct SizeView: View {
    @State private var animateGradient: Bool = false
    @State private var showCards: Bool = false
    private let startColor: Color = .blue
    private let endColor: Color = .green
    let shapes: [AnyView] = [
        AnyView(Circle().frame(width: 80, height: 80)),
        AnyView(Rectangle().frame(width: 80, height: 80)),
        AnyView(Rectangle().frame(width: 100, height: 50))
    ]

    var body: some View {
        ZStack {
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animateGradient)
                .onAppear {
                    animateGradient = true
                    withAnimation(.easeInOut(duration: 1).delay(0.5)) {
                        showCards = true
                    }
                }

            Text("Выбери фигуру")
                .font(.largeTitle)
                .fontWeight(.bold)
                .offset(y: -200)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(0..<shapes.count, id: \.self) { index in
                    VStack {
                        shapes[index]
                            .foregroundColor(.blue.opacity(0.4))
                            .opacity(showCards ? 1 : 0)
                            .scaleEffect(showCards ? 1 : 0.8)
                            .animation(.easeInOut(duration: 0.5).delay(0.2 * Double(index)), value: showCards)
                    }
                    .frame(width: 200, height: 200)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(30)
                }
            }
            .padding()
        }
    }
}


#Preview {
    SizeView()
}
