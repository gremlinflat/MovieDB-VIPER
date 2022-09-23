//
//  GenreCell.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 23/09/22.
//

import UIKit

class GenreCell: UICollectionViewCell {

    @IBOutlet weak var genreContainer: UIView!
    @IBOutlet weak var genreTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        genreContainer.backgroundColor = .systemBlue
        genreContainer.layer.cornerRadius = 10
    }
    
    public func setTitle(title: String){
        genreTitle?.textColor = .label
        genreTitle?.text = title
    }
}
