//
//  MKRocketsViewController.swift
//  rs.ios.stage-task11
//
//  Created by dev on 9.09.21.
//

import Foundation
import UIKit

class MKRocketsViewController: UIViewController {
    var presenter: MKRocketsPresenterProtocol?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.rsDarkBlue
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func didMove(toParent parent: UIViewController?) {
        configureTabBarItem()
    }
    
    func setup() {
        self.configureCollectionView()
    }
    
    func configureTabBarItem() {
        self.tabBarController?.delegate = self
        self.tabBarItem.title = "Rockets"
        self.tabBarItem.image = UIImage.rsRocket?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.selectedImage = UIImage.rsHighlightedRocket?.withRenderingMode(.alwaysOriginal)
        
        self.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.robotoRegular(ofSize: 10),
            NSAttributedString.Key.foregroundColor: UIColor.rsChampagne
        ], for: .normal)
        
        self.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.robotoRegular(ofSize: 10),
            NSAttributedString.Key.foregroundColor: UIColor.rsCoral
        ], for: .selected)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.rsArrows?.withRenderingMode(.alwaysOriginal),
                                                                 style: .plain,
                                                                 target: nil,
                                                                 action: #selector(sortCollectionView(sender:)))
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MKRocketsCollectionViewCell.self, forCellWithReuseIdentifier: MKRocketsCollectionViewCell.identifier)
        
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    @objc func sortCollectionView(sender: UIBarButtonItem) {
        
    }
}

extension MKRocketsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.rockets?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MKRocketsCollectionViewCell.identifier, for: indexPath) as! MKRocketsCollectionViewCell
        if let rocket = presenter?.rockets?[indexPath.item] {
            cell.configureCell(withRocket: rocket)
        }
        
        return cell
    }

    //MARK: - Flow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-36, height: collectionView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 18, bottom: 30, right: 18)
    }
    
    //MARK: - Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath) as! MKRocketsCollectionViewCell
        self.navigationController?.pushViewController(MKRocketsDetailedViewController(withLaunch: (self.presenter?.rockets?[indexPath.row])!, andCover: currentCell.imageView.image), animated: true)
    }
}

extension MKRocketsViewController: MKRocketsViewProtocol {
    func success() {
        self.collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error)
    }
}
