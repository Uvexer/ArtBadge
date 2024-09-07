import SwiftUI
import AVKit
import UIKit

class VideoPlayerUIView: UIView {
    private var playerLayer = AVPlayerLayer()
    
    var player: AVPlayer? {
        didSet {
            playerLayer.player = player
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayer()
    }
    
    private func setupLayer() {
        playerLayer.videoGravity = .resizeAspectFill
           playerLayer.masksToBounds = true
           playerLayer.cornerRadius = 12
           layer.addSublayer(playerLayer)
           
          
           self.layer.cornerRadius = 12
           self.layer.masksToBounds = true
      

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}

struct CustomVideoPlayerView: UIViewRepresentable {
    var player: AVPlayer
    
    func makeUIView(context: Context) -> VideoPlayerUIView {
        let view = VideoPlayerUIView()
        view.player = player
        return view
    }
    
    func updateUIView(_ uiView: VideoPlayerUIView, context: Context) {
    }
}

struct InfoNextMailView: View {
    @State private var player = AVPlayer()
    @State private var videoReadyToPlay = false
    private let startColor: Color = .blue
    private let endColor: Color = .green
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Text("Найди свое фото и сохрани")
                    .font(.largeTitle)
                    .bold()
                    .offset(y: 10)
                
                if videoReadyToPlay {
                    CustomVideoPlayerView(player: player)
                        .frame(width: 700, height: 960)
                        .padding(.bottom, 20)
                        .offset(y: 10)
                }
                
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
        .onAppear {
            if let videoURL = Bundle.main.url(forResource: "infoVideo", withExtension: "mov") {
                let playerItem = AVPlayerItem(url: videoURL)
                
                playerItem.asset.loadValuesAsynchronously(forKeys: ["playable"]) {
                    DispatchQueue.main.async {
                        if playerItem.asset.statusOfValue(forKey: "playable", error: nil) == .loaded {
                            player.replaceCurrentItem(with: playerItem)
                            videoReadyToPlay = true
                            player.play()
                            
                            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                                player.seek(to: .zero)
                                player.play()
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    InfoNextMailView()
}
