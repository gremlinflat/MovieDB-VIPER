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
    
    private init() {}
    
    static func build() -> UINavigationController {
        let baseView = GenreViewController()
        let interactor = MovieInteractor()
        let router = MovieRouter(viewController: baseView)
        let presenter = GenrePresenter(baseView: baseView, interactor: interactor, route: router)
        
        interactor.presenter = presenter
        baseView.presenter = presenter
        return UINavigationController(rootViewController: baseView)
    }
}
