//
//  ViewControllerForCountryDetails.swift
//  SearchMobiliyaPOC
//
//  Created by Ram Gade on 2020/01/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import UIKit
import SVGKit
import Foundation

class ViewControllerForCountryDetails: UIViewController {
    @IBOutlet weak var viewForFlag: FlagView!
    
    @IBOutlet weak var buttonToAddOffline: UIButton!
    @IBOutlet weak var labelForCountryName: UILabel!
    @IBOutlet weak var labelForCallingCode: UILabel!
    @IBOutlet weak var labelForLanguage: UILabel!
    @IBOutlet weak var labelForTimeZone: UILabel!
    @IBOutlet weak var labelForCurrency: UILabel!
    @IBOutlet weak var labelForSubregion: UILabel!
    @IBOutlet weak var labelForRegion: UILabel!
    @IBOutlet weak var labelForCapital: UILabel!
    var details:CountryDataModel?
    
    var isOffline = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        buttonToAddOffline.isHidden = isOffline
    }
    
    func setData() {
        labelForRegion.text = details?.region
        labelForCapital.text = details?.capital
        labelForLanguage.text = details?.capital
        labelForCurrency.text = details?.currency
        labelForSubregion.text = details?.subregion
        labelForCallingCode.text = details?.callingCode
        labelForCountryName.text = details?.countryName
        labelForTimeZone.text = details?.timeZone
        labelForLanguage.text = details?.language
        details?.imageData = SVGKExporterNSData.export(asNSData: viewForFlag.image)
        
        
        if let flag = details?.flag, let flagUrl = URL(string: flag), Reachability.isConnected() {
            if !flag.contains("shn.svg") {
                self.viewForFlag?.image = SVGKImage(contentsOf: flagUrl)
            }
        }
    }
    
    @IBAction func FnToAddDetailsToOffline(_ sender: Any) {
        
        DataBaseOperation.shared.addRecordToDatabase(countryData: details!)
    }
}
