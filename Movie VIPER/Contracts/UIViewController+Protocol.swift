//
//  BaseViewProtocol.swift
//  Movie VIPER
//
//  Created Fahri Novaldi on 23/09/22.

import UIKit

extension ViewProtocol where Self: UIViewController {
    
    func setNavigationBarTitleWith(_ title: String) {
        self.title = title
    }
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func showNegativeMessage() {
        
    }
    
    func showPositiveMessage() {
        
    }
}
