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
            
        case .movieList(let genreId, let page):
            networkManager.getMovieList(genreId: genreId, page: page) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let movies):
                    self.presenter?.receiveData(data: movies)
                case .failure(_):
                    fatalError()
                }
            }
            
        case .movieDetails(let movieId):
            networkManager.getMovieDetail(id: movieId) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let movie):
                    self.presenter?.receiveData(data: movie)
                case .failure(let error):
                    fatalError(error.rawValue)
                }
            }
        case .movieTrailer(let movieId):
            networkManager.getMovieTrailer(movieId: movieId) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let key):
                    self.presenter?.receiveData(data: key)
                case .failure(let error):
                    fatalError(error.rawValue)
                }
            }
        }
    }
}
