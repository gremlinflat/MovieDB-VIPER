//
//  ReviewTableViewCell.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var authorContent: UILabel!
    @IBOutlet weak var authorUsername: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI(){
        
    }
    
    func prepareCell(_ review: ReviewEntity) {
        authorUsername.text = review.author
        authorContent.text = review.content
        
        //TODO: IMAGE
        
    }
    
}
