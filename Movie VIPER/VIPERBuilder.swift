//
//  VIPERBuilder.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 23/09/22.
//

import Foundation
import UIKit

protocol VIPERModuleProtocol {
    static func build() -> UINavigationController
}

class MovieBuilder: VIPERModuleProtocol {
    static func build() -> UINavigationController {
        let viewController = RootViewController()
        
        return UINavigationController(rootViewController: viewController)
    }
}
