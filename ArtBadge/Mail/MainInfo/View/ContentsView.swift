import SwiftUI
import AVKit
import UIKit

struct ContentsView: View {
    @Binding var player: AVPlayer
    @Binding var videoReadyToPlay: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            
            TitleView()
            
            if videoReadyToPlay {
                VideoPlayerView(player: player)
                    .frame(width: 700, height: 960)
                    .padding(.bottom, 20)
            }
            
            HStack(spacing: 50) {
          
                Button(action: {
                    withAnimation {
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    
                    Text("Назад")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(Color.blue.opacity(0.9))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                }
                NavigationButtonView()
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

