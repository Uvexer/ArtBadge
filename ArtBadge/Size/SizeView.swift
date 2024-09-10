import SwiftUI

struct SizeView: View {
    @State private var animateGradient: Bool = false
    @State private var showCards: Bool = false
    @State private var selectedShape: (AnyView, String)? = nil
    private let startColor: Color = .blue
    private let endColor: Color = .green
    
    var body: some View {
        let cardColor = Color.white.opacity(0.2)
        let strokeColor = Color.blue.opacity(0.7)
        
        let shapes: [(AnyView, String)] = [
            (AnyView(Circle().fill(cardColor).overlay(Circle().stroke(strokeColor, lineWidth: 4)).frame(width: 100, height: 100)), "55x55"),
            (AnyView(Rectangle().fill(cardColor).overlay(Rectangle().stroke(strokeColor, lineWidth: 4)).frame(width: 100, height: 100)), "60x40"),
            (AnyView(Rectangle().fill(cardColor).overlay(Rectangle().stroke(strokeColor, lineWidth: 4)).frame(width: 140, height: 70)), "50x90")
        ]
        
        ZStack {
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animateGradient)
                .onAppear {
                    animateGradient = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 1)) {
                            showCards = true
                        }
                    }
                }
            
            VStack {
                if selectedShape == nil {
                    VStack(spacing: 30) {
                        Text("Выбери фигуру")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(0..<shapes.count, id: \.self) { index in
                                VStack {
                                    GeometryReader { geometry in
                                        shapes[index].0
                                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                            .opacity(showCards ? 1 : 0)
                                            .scaleEffect(showCards ? 1 : 0.8)
                                            .animation(.easeInOut(duration: 0.5).delay(0.2 * Double(index)), value: showCards)
                                    }
                                    .aspectRatio(1, contentMode: .fit)
                                    
                                    Text(shapes[index].1)
                                        .font(.title3)
                                        .foregroundColor(.black.opacity(0.7))
                                        .offset(y: -15)
                                        .padding(.top, 5)
                                }
                                .frame(width: 200, height: 200)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(30)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.5)) {
                                        selectedShape = shapes[index]
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .padding(.bottom, 60)
                } else if let selectedShape = selectedShape {
                    VStack {
                        selectedShape.0
                            .frame(width: 200, height: 200)
                            .scaleEffect(1)
                            .opacity(1)
                            .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.5))
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.5)) {
                                    self.selectedShape = nil
                                }
                            }) {
                                Text("Назад")
                                    .font(.title2)
                                    .padding()
                                    .frame(minWidth: 100, idealWidth: 150, maxWidth: 200)
                                    .background(Color.white)
                                    .foregroundColor(.blue)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.blue, lineWidth: 2)
                                    )
                            }
                            
                            Button(action: {
                              
                                print("Print action triggered")
                            }) {
                                Text("Печать")
                                    .font(.title2)
                                    .padding()
                                    .frame(minWidth: 100, idealWidth: 150, maxWidth: 200)
                                    .background(Color.white)
                                    .foregroundColor(.blue)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.blue, lineWidth: 2)
                                    )
                            }
                        }
                        .padding(.top, 20)
                        .opacity(1)
                        .animation(.easeInOut(duration: 0.6).delay(0.2))
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    SizeView()
}
