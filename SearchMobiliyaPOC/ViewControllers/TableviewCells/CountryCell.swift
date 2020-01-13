//
//  CountryCell.swift
//  SearchMobiliyaPOC
//
//  Created by Ram Gade on 2020/01/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import UIKit
import SVGKit

class CountryCell: UITableViewCell {
    
    @IBOutlet var countryView: UIView?
    @IBOutlet var flagView: FlagView?
    @IBOutlet var countryNameLabel: UILabel?
    @IBOutlet var populationCountLabel: UILabel?
    @IBOutlet var areaSizeLabel: UILabel?
    
    @IBOutlet weak var countryImageView: UIImageView!
    func config(withCountry country: CountryDataModel?) {

        if let flag = country?.flag, let flagUrl = URL(string: flag), Reachability.isConnected() {
            if !flag.contains("shn.svg") {
                self.flagView?.image = SVGKImage(contentsOf: flagUrl)
            }
        } else {
//        if country?.imageData != nil {
//            let receivedImage:SVGKImage = SVGKImage(data: country?.imageData)
//            self.flagView?.image = receivedImage
//        }
        }
        countryNameLabel?.text = country?.countryName
        areaSizeLabel?.text = "\(country?.areaSize ?? 0)"
    }
}
