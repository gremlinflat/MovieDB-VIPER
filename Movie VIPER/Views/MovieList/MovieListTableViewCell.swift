//
//  MovieListTableViewCell.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import UIKit
import Kingfisher

class MovieListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        print("sfag")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setupUI(){
        moviePoster.layer.cornerRadius = 12
    }
    
    func populate(movieEntity: MovieEntity) {
        movieTitle.text = movieEntity.title
        movieScore.text = String(format: " %.2f ", movieEntity.voteAverage)
        movieYear.text = movieEntity.relaseYear()
        movieOverview.text = movieEntity.overview
        
        let endpoint = EndPointFactory.shared.configure(for: .imageAsset(movieEntity.posterPath!))
        moviePoster.kf.setImage(with: URL(string: endpoint))
    }
}
