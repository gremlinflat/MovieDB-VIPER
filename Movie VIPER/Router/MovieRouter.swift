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
    
    func navigateToMovieList(in genre: GenreEntity, with presenter: PresenterProtocol) {
        
        let vc = UIStoryboard.init(name: "MovieList", bundle: nil).instantiateViewController(withIdentifier: "MovieListScene") as! MovieListViewController
        vc.presenter = presenter
        vc.genre = genre
        
        
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieDetail(for id: String,  with presenter: PresenterProtocol) {
        let vc = UIStoryboard.init(name: "DetailMovie", bundle: nil).instantiateViewController(withIdentifier: "DetailMovieScene") as! DetailMovieViewController
        
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
