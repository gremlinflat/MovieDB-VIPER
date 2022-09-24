//
//  DetailMovieViewController.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 24/09/22.
//

import UIKit

class DetailMovieViewController: UIViewController, ViewProtocol {
    var presenter: PresenterProtocol?
    var id: String = ""
    
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

        // Do any additional setup after loading the view.
    }

}
