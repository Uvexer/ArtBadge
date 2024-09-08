import SwiftUI
import AVKit
import UIKit
struct ContentsView: View {
    @Binding var player: AVPlayer
    @Binding var videoReadyToPlay: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            TitleView()
            
            if videoReadyToPlay {
                VideoPlayerView(player: player)
                    .frame(width: 700, height: 960)
                    .padding(.bottom, 20)
            }
            
            NavigationButtonView()
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}
