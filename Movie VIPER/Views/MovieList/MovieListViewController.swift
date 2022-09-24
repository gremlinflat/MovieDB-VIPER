//
//  MovieListViewController.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import UIKit

class MovieListViewController: UIViewController, MovieListProtocol {
    
    var presenter: PresenterProtocol?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var genre: GenreEntity?
    var moviesList: [MovieEntity] = []
    var page: Int = 1
    
    let cellIdentifier = "MovieCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.title = genre?.name
        title = genre?.name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        presenter?.fetchMovies(for: "\(genre!.id)", in: page)
    }

    func reloadMovies(data: [MovieEntity]) {
        print("masuk")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieListTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}
