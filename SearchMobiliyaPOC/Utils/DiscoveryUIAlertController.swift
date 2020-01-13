//
//  UIAlertControllerForAlert.swift
//  SearchMobiliyaPOC
//
//  Created by Ram Gade on 2020/01/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import Foundation
import UIKit

public class UIAlertControllerForAlert:NSObject {
    
    static let sharedInstance = UIAlertControllerForAlert()
    
    private override init() {
    }
    
    func showAlert(view: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(defaultAction)
        DispatchQueue.main.async(execute: {
            view.present(alert, animated: true)
        })
    }
    
    func showAlertOnMainWindowWithDoneAction(title: String, message: String, firstButtonTitle:String, secondButtonTitle:String, onOkAction: (() -> Void)?, onCancelAction:(() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: firstButtonTitle, style: .default, handler: { action in
            onOkAction!()
        })
        let secondAction = UIAlertAction(title: secondButtonTitle, style: .default, handler: { action in
            onCancelAction!()
        })
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        DispatchQueue.main.async(execute: {
            let controller = UIApplication.shared.keyWindow?.rootViewController
            controller?.present(alert, animated: true)
        })
    }
    
    func showAlertOnMainWindow(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(defaultAction)
        DispatchQueue.main.async(execute: {
            let controller = UIApplication.shared.keyWindow?.rootViewController
            controller?.present(alert, animated: true)
        })
    }
}
