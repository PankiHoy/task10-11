//
//  MKDetailedLaunchpadsViewController.swift
//  rs.ios.stage-task11
//
//  Created by dev on 17.09.21.
//

import UIKit
import MapKit

class MKLaunchpadsDetailedViewController: UIViewController {
    var launchPad: MKLaunchpad?
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 30
        view.axis = .vertical
        
        return view
    }()
    
    lazy var imageCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        view.backgroundColor = UIColor.rsWhite
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .rsWhite
        setup()
    }
    
    init(withLaunchpad launchpad: MKLaunchpad) {
        super.init(nibName: nil, bundle: nil)
        self.launchPad = launchpad
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        configureNavBar()
        configureScrollView()
        configureCover()
        configureStackViews()
    }
    
    func configureNavBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.rsCoral
        self.title = "\(launchPad?.name ?? "")"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.rsWhite,
            NSAttributedString.Key.font: UIFont.robotoBold(ofSize: 24)
        ]
    }
    
    func configureCover() {
        let coverView = UIView()
        
        let nameLabel = UILabel()
        nameLabel.makeRSLabel(withColor: UIColor.rsBlack, andFont: UIFont.robotoBold(ofSize: 24))
        nameLabel.text = launchPad?.name
        
        coverView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: coverView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: coverView.leadingAnchor)
        ])
        
        let fullNameLabel = UILabel()
        fullNameLabel.makeRSLabel(withColor: UIColor.rsBlack, andFont: UIFont.robotoBold(ofSize: 17))
        fullNameLabel.text = launchPad?.fullName
        fullNameLabel.numberOfLines = 0
        
        coverView.addSubview(fullNameLabel)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: coverView.topAnchor, constant: 38),
            fullNameLabel.leadingAnchor.constraint(equalTo: coverView.leadingAnchor),
            fullNameLabel.trailingAnchor.constraint(equalTo: coverView.trailingAnchor)
        ])
        
        let imageView = ShadowedView()
        imageView.layer.cornerRadius = 15
        
        let statusLabel = UILabel()
        statusLabel.makeRSLabel(withColor: UIColor.rsCyan, andFont: UIFont.robotoBold(ofSize: 17))
        
        if launchPad?.status == "active" {
            statusLabel.text = "Active"
        } else {
            statusLabel.text = "Retired"
        }
        
        imageView.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 5),
            statusLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10),
            statusLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5),
            statusLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -10),
        ])
        
        coverView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: coverView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: coverView.topAnchor, constant: 102)
        ])
        
        contentView.addSubview(coverView)
        coverView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            coverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            coverView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            coverView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40),
        ])
    }
    
    func configureStackViews() {
        stackView.addArrangedSubview(configureDescriptionBlock(withTitle: "Description", andDesctiption: launchPad!.details)!)
        stackView.addArrangedSubview(configureBlock(withTitle: "Overview", andData: [
            Unit(key: "Region", value: launchPad?.region),
            Unit(key: "Location", value: launchPad?.locality),
            Unit(key: "Launch attemts", value: launchPad?.launchAttempts),
            Unit(key: "Launch success", value: launchPad?.launchSuccesses)
        ])!)
        stackView.addArrangedSubview(configureImageCollectionBlock())
        stackView.addArrangedSubview(configureLocationBlock())
    }
    
    func configureImageCollectionBlock() -> UIView {
        imageCollection.delegate = self
        imageCollection.dataSource = self
        imageCollection.register(MKImageCollectionViewCell.self, forCellWithReuseIdentifier: MKImageCollectionViewCell.identifier)
        
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.makeRSLabel(withColor: UIColor.rsBlack, andFont: UIFont.robotoBold(ofSize: 24))
        nameLabel.text = "Images"
        
        stack.addArrangedSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor)
        ])
        
        stack.addArrangedSubview(imageCollection)
        imageCollection.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        return stack
    }
    
    func configureLocationBlock() -> UIView {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.makeRSLabel(withColor: UIColor.rsBlack, andFont: UIFont.robotoBold(ofSize: 24))
        nameLabel.text = "Location"
        
        stack.addArrangedSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor)
        ])
        
        let view = ShadowedView()
        view.layer.cornerRadius = 20
        
        let mapView = MKMapView()
        mapView.setCenter(CLLocationCoordinate2D(latitude: (self.launchPad!.latitude), longitude: (self.launchPad!.longitude)), animated: true)
        mapView.layer.cornerRadius = 16
        let annotations = [
            MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: (self.launchPad!.latitude), longitude: (self.launchPad!.longitude))),
            Annotation(title: (self.launchPad!.locality), coordinate: CLLocationCoordinate2D(latitude: (self.launchPad!.latitude), longitude: (self.launchPad!.longitude))) as MKAnnotation
        ]
        mapView.addAnnotations(annotations)
        
        mapView.isUserInteractionEnabled = false
        
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
        
        stack.addArrangedSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40).isActive = true
        view.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -20).isActive = true
        
        return stack
    }
    
    func configureScrollView() {
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 180),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }
    
}

extension MKLaunchpadsDetailedViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launchPad?.images.large.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MKImageCollectionViewCell.identifier, for: indexPath) as! MKImageCollectionViewCell
        cell.delegate = self
        cell.configureCell()
        cell.imageView.downloaded(from: (self.launchPad?.images.large[indexPath.row])!, contentMode: .scaleAspectFill)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 145, height: 196)
    }
}

class Annotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = title
        super.init()
    }
    
    var subtitle: String? {
        return title
    }
}
