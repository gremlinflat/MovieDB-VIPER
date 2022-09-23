//
//  MoviePresenter.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import UIKit

class MoviePresenter: PresenterProtocol{
    var baseView: UIViewController
    var interactor: InteractorProtocol
    var route: RouterProtocol
    
    init(baseView: UIViewController, interactor: InteractorProtocol, route: RouterProtocol) {
        self.baseView = baseView
        self.interactor = interactor
        self.route = route
    }
    
}

