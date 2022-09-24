//
//  Contracts.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 23/09/22.
//

import UIKit

protocol ViewProtocol: AnyObject {
    var presenter: PresenterProtocol? { get set }
    func showLoading()
    func hideLoading()
    func showNegativeMessage()
    func showPositiveMessage()
    
    func setNavigationBarTitleWith(_ title: String)
}

protocol InteractorProtocol: AnyObject {
    var presenter: PresenterProtocol? { get set }
    func reFetchData(kind endpoint: EndPoints)
    
}
protocol PresenterProtocol: AnyObject {
    var baseView: ViewProtocol { get set }
    var interactor: InteractorProtocol { get set }
    var route: RouterProtocol { get set }
    
    
    func fetchGenres()
    func fetchMovies(for genre: String, in page: Int)
//    func addingNewMonster()
//    func presentListOfMonsters(monsterType: MonsterType?)
//    func presentDetailOfMonsters(isDetail: Bool, monsterId: Monster?)
//    func requestListOfMonsters()
}

protocol RouterProtocol: AnyObject {
    func navigateToMovieList(in genre: GenreEntity, with presenter: PresenterProtocol)
    func navigateToMovieDetail(for id: String, with presenter: PresenterProtocol)
}

// MARK: Communication adapter
protocol GenreViewProtocol: ViewProtocol {
    func reloadGenres(data: [GenreEntity])
}

protocol GovieListProtocol: ViewProtocol {
    
}
