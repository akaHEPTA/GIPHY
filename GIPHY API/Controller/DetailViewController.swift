//
//  DetailViewController.swift
//  GIPHY API
//
//  Created by Richard Cho on 2021-11-27.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    private lazy var handler = CoreDataHandler.shared
    
    var data: Gif! {
        didSet {
            updateView()
        }
    }
    
    private var isFavorited = false
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isFavorited = handler.checkGif(by: data.id)
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: isFavorited ? "star.fill" : "star"),
            style: .plain,
            target: self,
            action: #selector(favoriteDidTap(_:)))
        setupView()
    }
    
    private func setupView() {
        view.addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: view.bounds.size.width).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
    }
    
    @objc func favoriteDidTap(_ sender: UIBarButtonItem) {
        if isFavorited {
            handler.deleteGif(id: data.id)
        } else {
            handler.saveGif(id: data.id, url: data.url)
        }
        isFavorited = !isFavorited
        sender.image = UIImage(systemName: isFavorited ? "star.fill" : "star")
    }
    
    private func updateView() {
        let url = data?.getOriginalURL()
        imageView.image = UIImage.gif(url: url!)
        title = data?.title
    }
    
}
