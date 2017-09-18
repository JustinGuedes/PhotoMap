//
//  LoadingView.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/23.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    static func fromNib() -> LoadingView {
        guard let view = UINib(nibName: "LoadingView", bundle: Bundle.main).instantiate(withOwner: .none, options: .none).first as? LoadingView else {
            fatalError("Can't find LoadingView")
        }
        
        return view
    }

}
