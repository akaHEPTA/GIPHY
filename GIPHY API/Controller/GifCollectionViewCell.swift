//
//  GifCollectionViewCell.swift
//  GIPHY API
//
//  Created by Richard Cho on 2021-11-26.
//

import UIKit

class GifCollectionViewCell: UICollectionViewCell {
    
    var gif: Gif?
    
    let imageView = UIImageView()

    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(imageView)
        guard let gif = gif else { return }
        let url = gif.getDownsizedURL()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.gif(url: url)
        imageView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        imageView.matchParent()
        imageView.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
