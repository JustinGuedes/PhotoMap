//
//  PhotosPageViewController.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/22.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class PhotosPageViewController: UIPageViewController {
    
    fileprivate var photosState: PhotosState {
        return photoMapStore.state.photosState
    }
    
    fileprivate var googleState: GoogleState {
        return photoMapStore.state.googleState
    }
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: .none, action: .none)
        dataSource = self
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoMapStore.subscribe(self)
        guard photosState.selectedPhoto < googleState.photos.count else {
            navigationController?.popViewController(animated: false)
            return
        }
        
        let photoViewController = PhotoViewController(withPhoto: googleState.photos[photosState.selectedPhoto])
        setViewControllers([photoViewController], direction: .forward, animated: false, completion: .none)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        photoMapStore.unsubscribe(self)
    }
    
}

extension PhotosPageViewController: Subscriber {
    
    func newState(_ state: PhotoMapState) {
        guard state.photosState.selectedPhoto < state.googleState.photos.count else {
            navigationController?.popViewController(animated: false)
            return
        }
        
        title = googleState.photos[state.photosState.selectedPhoto].title
    }
    
}

extension PhotosPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard photosState.selectedPhoto > 0 else {
            return .none
        }
        
        return PhotoViewController(withPhoto: googleState.photos[photosState.selectedPhoto - 1])
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard photosState.selectedPhoto < googleState.photos.count - 1 else {
            return .none
        }
        
        return PhotoViewController(withPhoto: googleState.photos[photosState.selectedPhoto + 1])
    }
    
}

extension PhotosPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else {
            return
        }
        
        guard let photoViewController = viewControllers?.first as? PhotoViewController,
            let newIndex = googleState.photos.index(where: { $0.id == photoViewController.photo.id }) else {
            fatalError("Should not ever happen")
        }
        
        photoMapStore.dispatch(
            .photosView(
                .selectedPhotoAtIndex(newIndex)
            )
        )
    }
    
}
