//
//  File.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/21.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

protocol Photo {
    
    var id: String { get }
    var title: String { get }
    
    func loadImage(_ callback: @escaping (UIImage?) -> Void)
    
}
