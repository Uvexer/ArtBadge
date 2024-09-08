import SwiftUI
import AVKit
//import UIKit

struct InfoNextMailView: View {
    @State private var player = AVPlayer()
    @State private var videoReadyToPlay = false
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            ContentsView(player: $player, videoReadyToPlay: $videoReadyToPlay)
        }
        .onAppear {
            prepareVideo()
        }
    }

    
    private func prepareVideo() {
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


