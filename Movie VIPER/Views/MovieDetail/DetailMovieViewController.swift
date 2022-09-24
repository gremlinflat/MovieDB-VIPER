//
//  DetailMovieViewController.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import UIKit
import Kingfisher

class DetailMovieViewController: UIViewController, ViewProtocol {
    var presenter: PresenterProtocol?
    var id: String = ""
    var trailerId: String = ""
    
    @IBOutlet weak var moviebanner: UIImageView!
    @IBOutlet weak var movieposter: UIImageView!
    @IBOutlet weak var movietitle: UILabel!
    @IBOutlet weak var movietagline: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    @IBOutlet weak var trailerButton: UIButton!
    
    @IBOutlet weak var reviewTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        trailerButton.isSelected = true
        
        presenter?.fetchMovie(id: id)
        presenter?.fetchMovieTrailer(id: id)
        movieposter.layer.cornerRadius = 12
    }
    
    func loadMovies(_ movie: MovieEntity) {
        movietitle.text = movie.title
        movietagline.text = movie.tagline
        movieScore.text = String(format: " %.2f ", movie.voteAverage)
        movieDate.text = movie.relaseYear()
        movieOverview.text = movie.overview
        
        loadImageAsset(path: movie.backdropPath!, in: moviebanner)
        loadImageAsset(path: movie.posterPath!, in: movieposter)
    }
    
    func setTrailerKey(key: String){
        trailerButton.isHidden = false
        self.trailerId = key
    }
    
    @IBAction func trailerButtonTapped(_ sender: Any) {
        var url = URL(string:"youtube://\(trailerId)")!
        if !UIApplication.shared.canOpenURL(url)  {
            url = URL(string:"http://www.youtube.com/watch?v=\(trailerId)")!
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        trailerButton.isSelected = false
    }
    func loadImageAsset(path: String, in imageView: UIImageView){
        let endpoint = EndPointFactory.shared.getImageURL(imgPath: path)
        let url = URL(string: endpoint)
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
}
