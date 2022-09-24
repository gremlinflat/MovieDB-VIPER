//
//  MovieListsTableViewCell.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setupUI(){
        moviePoster.layer.cornerRadius = 12
    }
    
    func populate(movieEntity: MovieEntity) {
        movieTitle.text = movieEntity.title
        movieScore.text = String(format: " %.2f ", movieEntity.voteAverage)
        movieYear.text = movieEntity.relaseYear()
        movieOverview.text = movieEntity.overview
        
        let endpoint = EndPointFactory.shared.getImageURL(imgPath: movieEntity.posterPath!)
        let url = URL(string: endpoint)
        let processor = DownsamplingImageProcessor(size: moviePoster.bounds.size) |> RoundCornerImageProcessor(cornerRadius: 20)
        moviePoster.kf.indicatorType = .activity
        moviePoster.kf.setImage(
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
