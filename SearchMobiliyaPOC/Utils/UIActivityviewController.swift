//
//  UIActivityviewController.swift
//  SearchMobiliyaPOC
//
//  Created by Ram Gade on 2020/01/10.
//  Copyright © 2020 Ram Gade. All rights reserved.
//

import Foundation
import  UIKit

class UIActivityviewController {
    
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    let loadingViewSize = 80, activityIndicatorSize = 40, frameSizeConstant = 0
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static let shared = UIActivityviewController()// Singleton
    
    func showActivityIndicator(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = .gray
        container.backgroundColor = UIColor.clear
        loadingView.frame = CGRect(x: frameSizeConstant, y: frameSizeConstant, width: loadingViewSize, height: loadingViewSize)
        loadingView.center = uiView.center
        loadingView.backgroundColor = .lightGray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: frameSizeConstant, y: frameSizeConstant, width: activityIndicatorSize, height: activityIndicatorSize)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator(uiView: UIView) {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.container.removeFromSuperview()
        }
    }
}
