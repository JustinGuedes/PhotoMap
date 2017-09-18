//
//  HomeViewController.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/19.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController, Subscriber {
    
    func newState(_ state: PhotoMapState) {
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoMapStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        photoMapStore.unsubscribe(self)
    }
    
}
