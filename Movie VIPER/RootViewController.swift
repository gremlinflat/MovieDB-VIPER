//
//  ViewController.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 22/09/22.
//

import UIKit

class RootViewController: UIViewController, BaseViewProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        navigationController?.pushViewController(DetailMovieViewController(), animated: true)
    }
    

}

