//
//  ViewController.swift
//  SearchMobiliyaPOC
//
//  Created by Ram Gade on 2020/01/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import UIKit

enum NetworkError: String, Error {
    case noInternet = "No internet connection available."
}

extension UITableViewCell {
    class var identifier: String {
        return String(describing: self)
    }
}

class ViewController: UIViewController,UITextFieldDelegate,CountryViewModelDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var textFieldForSearch: UITextField!
    @IBOutlet weak var searchCountryTableView: UITableView!
    private let countryViewModel = CountryViewModel()
    var countries = [CountryDataModel]()
    var countriesFromDB = [CountryDataModel]()
    var isOffline = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryViewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !Reachability.isConnected() {
            let result = DataBaseOperation.shared.retrieveCountryData()
            countries = result!
            isOffline = true
            DispatchQueue.main.async { [unowned self] in
                self.searchCountryTableView?.reloadData()
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.identifier, for: indexPath) as! CountryCell
        let data = countries[indexPath.row]
        cell.config(withCountry: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewControllerForCountryDetails") as? ViewControllerForCountryDetails
        vc?.details = countries[indexPath.row]
        vc?.isOffline = isOffline
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func searchForCountry(text:String) {
        if Reachability.isConnected() {
            UIActivityviewController.shared.showActivityIndicator(uiView: self.view)
            DispatchQueue.global(qos: .background).async {
                self.countryViewModel.requestCountriesByName(countryName: text)
            }
        } else {
            if let result = countryViewModel.searchDataInLocalDB(text:text) {
                countries = result
                DispatchQueue.main.async { [unowned self] in
                    self.searchCountryTableView?.reloadData()
                }
            }
        }
    }
    
    // MARK: - UITTextField Delegate Methods-----
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            searchForCountry(text: updatedText)
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Custom Delegate Methods-----

    func didReceiveCountries(countries: [CountryDataModel]) {
        if countries.count > 0 {
            self.countries.removeAll()
            self.countries = countries
        }
        DispatchQueue.main.async { [unowned self] in
            UIActivityviewController.shared.hideActivityIndicator(uiView:self.view)
            self.searchCountryTableView?.reloadData()
        }
    }
    
    func didFailDownloadCountries(error: Error) {
        print(error.localizedDescription)
        UIActivityviewController.shared.hideActivityIndicator(uiView: self.view)
    }
}

