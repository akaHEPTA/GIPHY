//
//  SearchCollectionViewController.swift
//  GIPHY API
//
//  Created by Richard Cho on 2021-11-26.
//

import UIKit

class SearchCollectionViewController: UIViewController {

    private let cellId = "GifCell"
    private let padding: CGFloat = 6
    
    private var collectionItems: [Gif] = []
    
    private let collectionView: UICollectionView = {
        let lt = UICollectionViewFlowLayout()
        lt.scrollDirection = .vertical
        lt.minimumInteritemSpacing = 6
        lt.minimumLineSpacing = 6
        lt.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: lt)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.delegate = self
        sc.searchBar.placeholder = "Search"
        sc.searchBar.scopeButtonTitles = ["Gifs", "Clips", "Stickers", "Text"]
        sc.automaticallyShowsScopeBar = true
        definesPresentationContext = true
        return sc
    }()
    
//    var searchText: String? {
//        didSet {
//            navigationItem.searchController?.searchBar.text = searchText
//            navigationItem.searchController?.searchBar.searchTextField.resignFirstResponder()
//            collectionView.reloadData()
//            searchForGifs()
//            title = searchText
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        collectionView.register(GifCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.searchController = searchController
        
        
        
    }

//    private func searchForGifs() {
//        guard let searchText = searchText else {
//            return
//        }
//
//    }

}

// MARK: - Data Source

extension SearchCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GifCollectionViewCell
        cell.backgroundColor = .blue
        return cell
    }
    
}

// MARK: - Delegate

extension SearchCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - self.padding) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom:  0, right: 0)
    }
    
}

extension SearchCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

// MARK: - Search Bar Delegate

extension SearchCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        APIHandler.shared.getSearchResult(with: query) { result in
            guard let result = result else { return }
            self.collectionItems = result.data
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("New scope index is now \(selectedScope)")
    }
}
