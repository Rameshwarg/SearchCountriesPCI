//
//  DataBaseOperation.swift
//  SearchMobiliyaPOC
//
//  Created by Ram Gade on 2020/01/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataBaseOperation {
    
    static let shared = DataBaseOperation()
    lazy var entityName: String = "Country"
    
    private init() {}
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    // MARK: - Core Data stack
    func addRecordToDatabase(countryData: CountryDataModel){
        let managedContext = appDelegate().persistentContainer.viewContext
        let countryEntity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        let user = NSManagedObject(entity: countryEntity, insertInto: managedContext)
        user.setValue(countryData.countryName, forKey: "name")
        user.setValue(countryData.currency, forKey: "currency")
        user.setValue(countryData.timeZone, forKey: "timezone")
        user.setValue(countryData.language, forKey: "language")
        user.setValue(countryData.callingCode, forKey: "callingcode")
        user.setValue(countryData.subregion, forKey: "subregion")
        user.setValue(countryData.capital, forKey: "capital")
        user.setValue(countryData.region, forKey: "region")
        user.setValue(countryData.flag, forKey: "flag")
        user.setValue(countryData.imageData, forKey: "imagedata")

        do {
            try managedContext.save()
            UIAlertControllerForAlert.sharedInstance
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveCountryData() -> [CountryDataModel]? {
        let managedContext =  appDelegate().persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let result = try managedContext.fetch(fetchRequest)
            let finalResult = (result as? [NSManagedObject])!
            var newsArray = [CountryDataModel]()
            for data in finalResult {
                newsArray.append(CountryDataModel.init(name: data.value(forKey: "name") as? String ?? "", population: 0, areaSize: 0.0, flag: data.value(forKey: "flag") as? String, capital: data.value(forKey: "capital") as? String, region: data.value(forKey: "region") as? String, subregion: data.value(forKey: "subregion") as? String, timeZone: data.value(forKey: "timezone") as? String, callingCode: data.value(forKey: "callingcode") as? String,image:data.value(forKey: "imagedata") as? Data))
            }
            return newsArray
        } catch {
            print("Failed")
        }
        return nil
    }
}
