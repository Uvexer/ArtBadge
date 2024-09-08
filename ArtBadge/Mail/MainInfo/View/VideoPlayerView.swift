import SwiftUI
import AVKit
import UIKit

struct VideoPlayerView: View {
    var player: AVPlayer
    
    var body: some View {
        CustomVideoPlayerView(player: player)
    }
}

