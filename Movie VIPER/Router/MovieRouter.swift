//
//  MovieRouter.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 23/09/22.
//

import UIKit

class MovieRouter: RouterProtocol {
    unowned let viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func navigateToMovieList(in genre: String) {
//        viewController?.navigationController?.pushViewController(_, animated: true)
    }
    
    func navigateToMovieDetail(for id: String) {
        let vc = DetailMovieViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
