//
//  MKLaunchpadsViewController.swift
//  rs.ios.stage-task11
//
//  Created by dev on 13.09.21.
//

import Foundation
import UIKit

class MKLaunchpadsViewController: UIViewController {
    var presenter: MKLaunchpadsPresenterProtocol?
    
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
        collectionView.register(MKLaunchpadsCollectionViewCell.self, forCellWithReuseIdentifier: MKLaunchpadsCollectionViewCell.identifier)
        
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureTabBarItem() {
        self.tabBarController?.delegate = self
        self.tabBarItem.title = "Launches"
        self.tabBarItem.image = UIImage.rsLego?.withRenderingMode(.alwaysOriginal)
        self.tabBarItem.selectedImage = UIImage.rsHighlightedLego?.withRenderingMode(.alwaysOriginal)
        
        self.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.robotoRegular(ofSize: 10),
            NSAttributedString.Key.foregroundColor: UIColor.rsChampagne
        ], for: .normal)
        
        self.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.robotoRegular(ofSize: 10),
            NSAttributedString.Key.foregroundColor: UIColor.rsCoral
        ], for: .selected)
    }
    
    @objc func sortCollectionView(sender: AnyObject) {
        
    }
}

extension MKLaunchpadsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.launchpads?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MKLaunchpadsCollectionViewCell.identifier, for: indexPath) as! MKLaunchpadsCollectionViewCell
        if let launchpad = presenter?.launchpads?[indexPath.item] {
            cell.configureCell(withLaunchpad: launchpad)
        }
        
        return cell
    }
    
    //MARK: - Flow Layout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-36, height: 145)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 18, bottom: 30, right: 18)
    }
    
    //MARK: - Delegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(UIViewController(), animated: true)
    }
}

extension MKLaunchpadsViewController: MKLaunchpadsViewProtocol {
    func success() {
        self.collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error)
    }
}
