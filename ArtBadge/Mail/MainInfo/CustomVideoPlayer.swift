import SwiftUI
import AVKit
import UIKit


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
