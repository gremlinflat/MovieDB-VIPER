//
//  MovieInteractor.swift
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
                    self.presenter?.receiveData(data: genres)
                case .failure(_):
                    fatalError()
                }
            }
        case .movieList(let genre, let page):
            networkManager.getMovies(genre: genre, page: page) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let movies):
                    self.presenter?.receiveData(data: movies)
                case .failure():
                    fatalError()
                }
            }
        case .movieDetails(let id):
//            networkManager.getMovie(id: id) { [weak self] result in
//                guard let self = self else { return }
//
//                switch result {
//                case .success(let movie):
//                    self.presenter?.receiveData(data: movie)
//                case .failure(_):
//                    fatalError()
//                }
//            }
            fatalError()
        case .movieVideo(_):
            fatalError()
        }
    }
    
    var presenter: PresenterProtocol?
    var networkManager: NetworkManager = NetworkManager.shared
}
