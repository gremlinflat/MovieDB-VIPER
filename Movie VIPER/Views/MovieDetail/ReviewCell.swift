//
//  ReviewTableViewCell.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import UIKit
import Kingfisher

class ReviewCell: UITableViewCell {

    @IBOutlet weak var authorContent: UILabel!
    @IBOutlet weak var authorUsername: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    private func setupUI(){
        authorImage.layer.cornerRadius = 60
    }
    
    func prepareCell(_ review: ReviewEntity) {
        authorUsername.text = review.author
        authorContent.text = review.content
        
        if let path = review.avatarPath {
            var url = URL(string: path)
            if !UIApplication.shared.canOpenURL(url!){
                let endpoint = EndPointFactory.shared.getImageURL(imgPath: path)
                url = URL(string: endpoint)
            }
            
                
            authorImage.kf.indicatorType = .activity
            let processor = DownsamplingImageProcessor(size: authorImage.bounds.size)
            authorImage.kf.setImage(
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
    
}
