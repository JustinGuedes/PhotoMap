//
//  PhotoViewController.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/22.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    let photo: Photo
    
    fileprivate var imageView: UIImageView!
    
    init(withPhoto photo: Photo) {
        self.photo = photo
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = photo.title
        view.backgroundColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: .none, action: .none)
        configureImageView()
    }

    fileprivate func configureImageView() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        photo.loadImage(setPhotoImage)
    }
    
    fileprivate func setPhotoImage(_ image: UIImage?) {
        imageView.image = image
    }

}
