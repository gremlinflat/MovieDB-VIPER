//
//  MoviePresenter.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import UIKit

class GenrePresenter: PresenterProtocol{
    
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
    
    func fetchMovies(for genre: String, in page: Int){
        interactor.reFetchData(kind: .movieList(genre, page))
    }
    
}

