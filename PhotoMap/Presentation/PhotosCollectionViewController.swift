//
//  PhotosCollectionViewController.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/21.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

private let reuseIdentifier = "photoCell"

class PhotosCollectionViewController: UICollectionViewController {

    fileprivate var googleState: GoogleState {
        return photoMapStore.state.googleState
    }
    
    fileprivate var loadingView = LoadingView.fromNib()
    fileprivate var noPhotosView = NoResultsView.fromNib(noResultsText: "No Photos")
    
    init() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let photoCellNib = UINib(nibName: "PhotoCollectionViewCell", bundle: Bundle.main)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: .none, action: .none)
        collectionView?.backgroundColor = UIColor.groupTableViewBackground
        collectionView?.register(photoCellNib, forCellWithReuseIdentifier: reuseIdentifier)
        configureLoadingView()
        configureNoPhotosView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoMapStore.subscribe(self)
        photoMapStore.dispatch(
            .googleService(
                .getPhotosForSelectedPlace
            )
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        photoMapStore.unsubscribe(self)
    }

}

// MARK: - Subscriber

extension PhotosCollectionViewController: Subscriber {
    
    func newState(_ state: PhotoMapState) {
        title = state.photosState.selectedPlace?.name
        
        loadingView.isHidden = !state.googleState.isLoadingData
        noPhotosView.isHidden = state.googleState.photos.count > 0
        collectionView?.isHidden = state.googleState.photos.count == 0
        
        collectionView?.reloadData()
    }
    
}

// MARK: - UICollectionViewDataSource

extension PhotosCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return googleState.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("Not photo cell")
        }
        
        cell.loadPhoto(googleState.photos[indexPath.row])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension PhotosCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photoMapStore.dispatch(
            .photosView(
                .selectedPhotoAtIndex(indexPath.row)
            )
        )
        
        let photosPageViewController = PhotosPageViewController()
        navigationController?.pushViewController(photosPageViewController, animated: true)
    }
    
}

// MARK: - Private

extension PhotosCollectionViewController {
    
    fileprivate func configureLoadingView() {
        view.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.sendSubview(toBack: loadingView)
    }
    
    fileprivate func configureNoPhotosView() {
        view.addSubview(noPhotosView)
        noPhotosView.translatesAutoresizingMaskIntoConstraints = false
        noPhotosView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        noPhotosView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        noPhotosView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        noPhotosView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.sendSubview(toBack: noPhotosView)
    }
    
}
