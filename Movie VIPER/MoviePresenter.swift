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
            (viewPresented as? MovieDetailViewController)?.loadMovies(movie)
        }
        if let ytkey = data as? String {
            (viewPresented as? MovieDetailViewController)?.setTrailerKey(key: ytkey)
        }
        if let reviews = data as? [ReviewEntity] {
            (viewPresented as? MovieDetailViewController)?.reloadReviews(data: reviews)
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
        interactor.reFetchData(kind: .movieTrailer(id))
    }
    
    func fetchMovieReview(id: String) {
        interactor.reFetchData(kind: .movieReview(id))
    }
}

