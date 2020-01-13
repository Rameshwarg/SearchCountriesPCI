//
//  FlagCell.swift
//  SearchMobiliyaPOC
//
//  Created by Ram Gade on 2020/01/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import UIKit
import SVGKit

class FlagCell: UITableViewCell {
    
    @IBOutlet weak var flagView: FlagView?
    
    func config(with flagUrlString: String?) {
        if let flagUrlString = flagUrlString, let flagUrl = URL(string: flagUrlString), Reachability.isConnected() {
            flagView?.image = SVGKImage(contentsOf: flagUrl)
        }
    }
}
