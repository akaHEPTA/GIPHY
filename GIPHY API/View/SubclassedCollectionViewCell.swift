//
//  SubclassedCollectionViewCell.swift
//  GIPHY API
//
//  Created by Richard Cho on 2021-11-28.
//

import UIKit
import AVFoundation

class SubclassedCollectionViewCell: UICollectionViewCell {
    
    var gif: Gif?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        playerView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        playerView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        playerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    var playerView: PlayerView = {
        var player = PlayerView()
        player.backgroundColor = .lightGray
        return player
    }()
    
    var videoPlayer: AVPlayer? = nil

        func playVideo() {
            videoPlayer = AVPlayer(url: URL(string: gif!.getDownsizedVideoURL())!)
            videoPlayer?.playImmediately(atRate: 1)
            playerView.player = videoPlayer
        }
        
        func stopVideo() {
            playerView.player?.pause()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
}
