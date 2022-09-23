//
//  ViewController.swift
//  Movie VIPER
//
//  Created by Fahri Novaldi on 22/09/22.
//

import UIKit

class GenreViewController: UIViewController, ViewProtocol {
    var presenter: PresenterProtocol?

    var collectionView: UICollectionView!
    
    let cellIdentifier = "GenreCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarTitleWith("Genre")
        navigationController?.navigationBar.prefersLargeTitles = true
        layoutUI()
        collectionView.register(GenreCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        let nibCell = UINib(nibName: cellIdentifier, bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: cellIdentifier)
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

}

extension GenreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO: FIX
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! GenreCell
        
        cell.setTitle(title: "aaaa")
        
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
