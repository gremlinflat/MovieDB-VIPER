//
//  MoviePresenter.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import UIKit

class MoviePresenter: PresenterProtocol {
    func receiveData<T>(data: T) {
        if let genres = data as? [GenreEntity] {
            (viewPresented as? GenreViewProtocol)?.reloadGenres(data: genres)
        }
        
        if let movies = data as? [MovieEntity] {
            (viewPresented as? MovieListViewController)?.reloadMovies(data: movies)
        }
        if let movie = data as? MovieEntity {
            (viewPresented as? DetailMovieViewController)?.loadMovies(movie)
        }
        if let ytkey = data as? String {
            (viewPresented as? DetailMovieViewController)?.setTrailerKey(key: ytkey)
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
    
    func fetchMovie(id: String) {
        interactor.reFetchData(kind: .movieDetails(id))
    }
    
    func fetchMovieTrailer(id: String) {
        print("presenter")
        interactor.reFetchData(kind: .movieTrailer(id))
    }
    
}

