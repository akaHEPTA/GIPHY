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
    private var root: Root!
    private var collectionView: UICollectionView!
    
    private var searchTerm: String? = nil
//    private var scopeIndex: Int = 0
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.placeholder = "Search"
        sc.searchBar.delegate = self
        sc.searchBar.scopeButtonTitles = ["Gifs", "Clips", "Stickers", "Text"]
        sc.automaticallyShowsScopeBar = true
        definesPresentationContext = true
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lt = UICollectionViewCustomLayout()
        lt.delegate = self
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: lt)
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.matchParent()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GifCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.searchController = searchController
        navigationItem.searchController?.delegate = self
        
    }
    
    private func searchRequest(with query: String) {
        APIHandler.shared.getSearchResult(with: query) { [weak self] result in
            guard let result = result else {return}
            DispatchQueue.main.async {
                self?.collectionItems = result.data
                self?.collectionView.reloadData()
            }
        }
    }
    
}

// MARK: - Collection View Delegate & Data Source

extension SearchCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    /// Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! GifCollectionViewCell
        cell.gif = collectionItems[indexPath.item]
        return cell
    }
    
    /// Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection View Delegate: selected index path is \(indexPath)")
        let detailVC = DetailViewController()
        detailVC.data = collectionItems[indexPath.item]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


// MARK: - Custom Layout Delegate

extension SearchCollectionViewController: UICollectionViewCustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let temp = Int(collectionItems[indexPath.item].variants.downsized.height)!
        print(temp)
        return CGFloat(temp)
    }
}

// MARK: - Search Bar Delegate & Search Controller Delegate

extension SearchCollectionViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        searchTerm = query
        title = query
        searchRequest(with: query)
    }
    
    // SEARCH SCOPE IS NOT REQUIRED - FIX LATER - Nov. 27
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        guard let query = searchBar.text else { return }
//        scopeIndex = selectedScope
//        searchRequest(with: query)
    }
}
