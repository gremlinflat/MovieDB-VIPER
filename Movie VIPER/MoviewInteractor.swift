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
                    self.presenter?.baseView.reloadGenres(data: genres)
                case .failure(_):
                    fatalError()
                }
            }
        case .movieList(_, _):
            fatalError()
        case .movieDetails(_):
            fatalError()
        case .movieVideo(_):
            fatalError()
        case .imageAsset(_):
            fatalError()
        }
    }
    
    var presenter: PresenterProtocol?
    var networkManager: NetworkManager = NetworkManager.shared
}
