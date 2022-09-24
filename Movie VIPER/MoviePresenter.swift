//
//  MoviePresenter.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import UIKit

class MoviePresenter: PresenterProtocol {
    func receiveData<T>(data: T) {
        if let a = data as? [GenreEntity] {
            (viewPresented as? GenreViewProtocol)?.reloadGenres(data: a)
        }
        
        if let b = data as? [MovieEntity] {
            (viewPresented as? MovieListViewController)?.reloadMovies(data: b)
        }
    }
    
    var viewPresented: ViewProtocol
    
    var interactor: InteractorProtocol
    var route: RouterProtocol
    
    init(baseView: ViewProtocol, interactor: InteractorProtocol, route: RouterProtocol) {
        self.viewPresented = baseView
        self.interactor = interactor
        self.route = route
    }
    
    func fetchGenres() {
        interactor.reFetchData(kind: .genre)
    }
    
    func fetchMovies(for genre: String, in page: Int) {
        interactor.reFetchData(kind: .movieList(genre, page))
    }
    
    func fetchMovies(id: String) {
        interactor.reFetchData(kind: .movieDetails(id))
    }
    
}
