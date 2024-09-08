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

