//
//  FlagView.swift
//  SearchMobiliyaPOC
//
//  Created by Ram Gade on 2020/01/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import UIKit
import SVGKit

class FlagView: SVGKFastImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 0.5
        //layer.borderColor = UIColor.anthracite.cgColor
    }
}
