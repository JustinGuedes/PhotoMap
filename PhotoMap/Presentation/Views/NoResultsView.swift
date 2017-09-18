//
//  NoResultsView.swift
//  PhotoMap
//
//  Created by Justin Guedes on 2017/04/23.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class NoResultsView: UIView {

    @IBOutlet weak var noResultsLabel: UILabel!
    
    static func fromNib(noResultsText: String) -> NoResultsView {
        guard let view = UINib(nibName: "NoResultsView", bundle: Bundle.main).instantiate(withOwner: .none, options: .none).first as? NoResultsView else {
            fatalError("Can't find NoResultsView")
        }
        
        view.noResultsLabel.text = noResultsText
        return view
    }

}
