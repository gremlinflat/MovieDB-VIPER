//
//  MovieInteractor.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import Foundation

class MovieInteractor: InteractorProtocol {
    
    var presenter: PresenterProtocol?
    var networkManager: NetworkManager = NetworkManager.shared
    
    
    func reFetchData(kind endpoint: EndPoints) {
        
        switch endpoint {
        case .genre:
            networkManager.getGenres { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let genres):
                    self.presenter?.receiveData(data: genres)
                case .failure(_):
                    fatalError()
                }
            }
        case .movieList(let genre, let page):
            networkManager.getMovieList(genre: genre, page: page) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let movies):
                    self.presenter?.receiveData(data: movies)
                case .failure():
                    fatalError()
                }
            }
        case .movieDetails(let movieId):
            networkManager.getMovieDetail(id: movieId) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let movie):
                    self.presenter?.receiveData(data: movie)
                case .failure(_):
                    fatalError()
                }
            }
            break
        case .movieVideo(_):
            fatalError()
        }
    }
}
