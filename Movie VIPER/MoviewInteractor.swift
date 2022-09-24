//
//  MoviewInteractor.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import Foundation

class MovieInteractor: InteractorProtocol {
    func reFetchData(kind endpoint: EndPoints) {
        switch endpoint {
            
        case .genre:
            networkManager.getGenres { [weak self] result in
                
                guard let self = self else { return }
                switch result {
                case .success(let genres):
                    (self.presenter?.viewPresented as? GenreViewProtocol)?.reloadGenres(data: genres)
                case .failure(_):
                    fatalError()
                }
            }
        case .movieList(let genre, let page):
            networkManager.getMovies(for: genre, in: page) { [weak self] result in
               
                guard let self = self else { return }
            
                switch result {
                    
                case .success(let movies):
                    print("interactor sucess")
                    (self.presenter?.viewPresented as? MovieListViewController)?.reloadMovies(data: movies)
                case .failure(_):
                    fatalError()
                }
            }
        case .movieDetails(_):
            fatalError()
        case .movieVideo(_):
            fatalError()
        }
    }
    
    var presenter: PresenterProtocol?
    var networkManager: NetworkManager = NetworkManager.shared
}
