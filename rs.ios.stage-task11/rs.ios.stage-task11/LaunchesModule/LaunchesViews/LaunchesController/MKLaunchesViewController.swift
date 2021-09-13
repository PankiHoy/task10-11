//
//  File.swift
//  rs.ios.stage-task11
//
//  Created by dev on 11.09.21.
//

import Foundation
import UIKit

class MKLaunchesViewController: UIViewController {
    var presenter: MKLaunchesPresenterProtocol?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .rsDarkBlue
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        self.configureTabBarItem()
    }
    
    func setup() {
        self.configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MKLaunchesCollectionViewCell.self, forCellWithReuseIdentifier: MKLaunchesCollectionViewCell.identifier)
        
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureTabBarItem() {
        self.tabBarItem.title = "Launches"
        self.tabBarItem.image = UIImage.rsAdjustment?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.selectedImage = UIImage.rsHighlightedAdjustment?.withRenderingMode(.alwaysOriginal)
        
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
    
    @objc func sortCollectionView(sender: AnyObject) {
        
    }
}

extension MKLaunchesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.launches?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MKLaunchesCollectionViewCell.identifier, for: indexPath) as! MKLaunchesCollectionViewCell
        if let launch = presenter?.launches?[indexPath.item] {
            cell.configureCell(withLaunch: launch)
        }
        
        return cell
    }
    
    //MARK: - Flow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 145)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
    }
    
    //MARK: - Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(UIViewController(), animated: true)
    }
}

extension MKLaunchesViewController: MKLaunchesViewProtocol {
    func success() {
        collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error)
    }
}
