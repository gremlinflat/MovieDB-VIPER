//
//  MovieListViewController.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import UIKit

class MovieListViewController: UIViewController, MovieListViewProtocol {
    
    var presenter: PresenterProtocol?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var genre: GenreEntity?
    var moviesList: [MovieEntity] = []
    var page: Int = 1
    
    let cellIdentifier = "MovieCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let uinib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(uinib, forCellReuseIdentifier: cellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter?.fetchMovies(for: "\(genre?.id ?? -1)", in: page)
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationItem.title = genre?.name
        title = genre?.name
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func reloadMovies(data: [MovieEntity]) {
        moviesList = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieCell
        cell.populate(movieEntity: moviesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - (2*height) {
            page += 1
            presenter?.fetchMovies(for: "\(genre?.id ?? -1)", in: page)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.route.navigateToMovieDetail(for: moviesList[indexPath.row].title, id: "\(moviesList[indexPath.row].id)", with: presenter!)
    }
}
