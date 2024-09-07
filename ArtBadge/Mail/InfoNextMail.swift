import SwiftUI
import AVKit

struct CustomVideoPlayer: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.videoGravity = .resizeAspectFill
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    }
}
struct InfoNextMailView: View {
    @State private var player = AVPlayer()
    @State private var animateGradient: Bool = false
    private let startColor: Color = .blue
    private let endColor: Color = .green
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
            
            VStack {
                Spacer()
                
                Text("Найди свое фото и сохрани")
                    .font(.largeTitle)
                    .bold()
                    .offset(y: 10)
                
                CustomVideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "infoVideo", withExtension: "mov")!))
                    .frame(width: 700, height: 960)
                    .padding(.bottom, 20)
                    .offset(y: 10)
                
                NavigationLink(destination: MailPhotoView()) {
                    Text("Далее")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    InfoNextMailView()
}
