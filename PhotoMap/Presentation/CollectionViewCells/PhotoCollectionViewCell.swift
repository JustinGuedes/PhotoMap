//
//  PhotoCollectionViewCell.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/21.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    func loadPhoto(_ photo: Photo) {
        loadingView.isHidden = false
        photoImageView.isHidden = true
        photo.loadImage { image in
            self.photoImageView.image = image
            self.loadingView.isHidden = true
            self.photoImageView.isHidden = false
        }
    }

}
