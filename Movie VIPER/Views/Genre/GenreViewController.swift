//
//  ViewController.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 22/09/22.
//

import UIKit

class GenreViewController: UIViewController, GenreViewProtocol {
    
    var presenter: PresenterProtocol?

    var collectionView: UICollectionView!
    
    let cellIdentifier = "GenreCell"
    
    var genres: [GenreEntity]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarTitleWith("Genre")
        
        DispatchQueue.main.async {
            self.layoutUI()
            
            let nibCell = UINib(nibName: self.cellIdentifier, bundle: nil)
            self.collectionView.register(nibCell, forCellWithReuseIdentifier: self.cellIdentifier)
        }
        
        presenter?.fetchGenres()
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func layoutUI() {
        let layout = UICollectionViewFlowLayout()
        
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    func reloadGenres(data: [GenreEntity]) {
        genres = data
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension GenreViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO: FIX
        return genres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! GenreCell
        
        cell.setTitle(title: genres?[indexPath.row].name ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = view.bounds.width / 2
        return CGSize(width: itemWidth - 5 , height: (itemWidth - 5) * 0.6 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension GenreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.route.navigateToMovieList(in: (genres?[indexPath.row])!, with: presenter!)
    }
}
