//
//  MKRocketsDetailedViewController.swift
//  rs.ios.stage-task11
//
//  Created by dev on 14.09.21.
//

import UIKit
import WebKit

class MKRocketsDetailedViewController: UIViewController {
    var rocket: MKRocket?
    var cover: UIImage?
    
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
        view.contentInset.right = 20
        
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
        self.navigationController?.isNavigationBarHidden = true
        setup()
    }
    
    init(withLaunch rocket: MKRocket, andCover cover: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        self.rocket = rocket
        self.cover = cover
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        configureCoverImage()
        configureStackView()
        configureStackViewViews()
    }
    
    func configureCoverImage() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        let shadowImage = UIImage(named: "gradient")
        let shadowView = UIImageView(image: shadowImage)
        
        imageView.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: imageView.topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
        ])
        
        let backButton = UIImageView()
        imageView.isUserInteractionEnabled = true
        backButton.image = UIImage.rsBack
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backToRoots(sender:))))
        
        imageView.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 60),
            backButton.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20)
        ])
        
        if let cover = cover {
            imageView.image = cover
        } else {
            imageView.image = UIImage.rsPlaceholder
            DispatchQueue.global().async { [weak self] in
                URLSession.shared.dataTask(with: (self?.rocket?.flickrImages.last!)!) { data, _, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: data!)
                    }
                }.resume()
            }
        }
        
        let nameLabel = UILabel()
        nameLabel.makeRSLabel(withColor: UIColor.rsWhite, andFont: UIFont.robotoBold(ofSize: 48))
        nameLabel.text = rocket?.name
        
        imageView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            nameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -30)
        ])

        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    
    func configureStackView() {
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -50),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: UIScreen.main.bounds.width + 40),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -50)
        ])
    }
    
    func configureStackViewViews() {
        stackView.addArrangedSubview(configureDescriptionBlock(withTitle: "Description", andDesctiption: rocket!.description)!)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let date = formatter.date(from: rocket!.firstFlight)
        formatter.dateFormat = "MMMM dd, yyyy"
        
        stackView.addArrangedSubview(configureBlock(withTitle: "Overview", andData: [
            Unit(key: "First Launch", value: formatter.string(from:date!)),
            Unit(key: "Launch cost", value: "\(rocket?.costPerLaunch ?? -1)$"),
            Unit(key: "Success", value: "\(rocket?.success ?? -1)%"),
            Unit(key: "Mass", value: "\(rocket?.mass.kg ?? -1) kg"),
            Unit(key: "Height", value: "\(rocket?.height.meters ?? -1) meters"),
            Unit(key: "Diameter", value: "\(rocket?.diameter.meters ?? -1) meters")
        ])!)
        
        stackView.addArrangedSubview(configureImageCollectionBlock())
        
        stackView.addArrangedSubview(configureBlock(withTitle: "Engines", andData: [
            Unit(key: "Type", value: rocket?.engines.type),
            Unit(key: "Layout", value: rocket?.engines.layout),
            Unit(key: "Version", value: rocket?.engines.version),
            Unit(key: "Amount", value: rocket?.engines.number),
            Unit(key: "Propellant 1", value: rocket?.engines.propellant1),
            Unit(key: "Propellant 2", value: rocket?.engines.propellant2)
        ])!)
        
        if rocket?.firstStage != nil {
            stackView.addArrangedSubview(configureBlock(withTitle: "First Stage", andData: [
                Unit(key: "Reusable", value: rocket?.firstStage.reusable),
                Unit(key: "Engines amount", value: rocket?.firstStage.engines),
                Unit(key: "Fuel amlunt", value: "\(rocket?.firstStage.fuelAmountTons ?? -1) tons"),
                Unit(key: "Burning time", value: "\(rocket?.firstStage.burnTimeSec ?? -1) seconds"),
                Unit(key: "Thrust(sea level)", value: "\(rocket?.firstStage.thrustSeaLevel.kN ?? -1) kN"),
                Unit(key: "Thrust(vacuum)", value: "\(rocket?.firstStage.thrustVacuum.kN ?? -1) kN")
            ])!)
        }
        
        if rocket?.secondStage != nil {
            stackView.addArrangedSubview(configureBlock(withTitle: "Second Stage", andData: [
                Unit(key: "Reusable", value: rocket?.secondStage.reusable),
                Unit(key: "Engines amount", value: rocket?.secondStage.engines),
                Unit(key: "Fuel amount", value: "\(rocket?.secondStage.fuelAmountTons ?? -1) tons"),
                Unit(key: "Burning time", value: "\(rocket?.secondStage.burnTimeSec ?? -1) seconds"),
                Unit(key: "Thrust", value: "\(rocket?.secondStage.thrust?.kN ?? -1) kN")
            ])!)
        }
        
        if rocket?.landingLegs != nil {
            stackView.addArrangedSubview(configureBlock(withTitle: "Landing legs", andData: [
                Unit(key: "Amount", value: rocket?.landingLegs.number),
                Unit(key: "Material", value: rocket?.landingLegs.material)
            ])!)
        }
        
        stackView.addArrangedSubview(configureMaterialsBlock(withTitle: "Materials", andMaterials: [rocket!.wikipedia]))
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
    
    
    func configureMaterialsBlock(withTitle title: String, andMaterials materials: [URL]) -> UIView {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.makeRSLabel(withColor: UIColor.rsBlack, andFont: UIFont.robotoBold(ofSize: 24))
        nameLabel.text = title
        
        stack.addArrangedSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor)
        ])
        
        let wikiLabel = ShadowedView()
        wikiLabel.makeRSMaterialsLabel(withTitle: "Wikipedia")
        
        wikiLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(accessWikipedia)))
        wikiLabel.isUserInteractionEnabled = true

        stack.addArrangedSubview(wikiLabel)
        wikiLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            wikiLabel.widthAnchor.constraint(equalToConstant: 117),
            wikiLabel.heightAnchor.constraint(equalToConstant: 32),
        ])
        stack.alignment = .leading
        
        return stack
    }
    
    func configureWebView() -> WKWebView {
        let webView = WKWebView()
        
        let toolBar = UIToolbar()
        toolBar.backgroundColor = UIColor.rsDarkBlue
        
        webView.addSubview(toolBar)
        
        webView.load(URLRequest(url: rocket!.wikipedia))
        
        return webView
    }
    
    @objc func backToRoots(sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func accessWikipedia() {
        let webC = MKWebViewController(withURL: rocket!.wikipedia)
        self.navigationController?.present(webC, animated: true, completion: nil)
    }
}

extension MKRocketsDetailedViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rocket?.flickrImages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MKImageCollectionViewCell.identifier, for: indexPath) as! MKImageCollectionViewCell
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! MKImageCollectionViewCell
        cell.configureCell(withImage: rocket!.flickrImages[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 145, height: 196)
    }
}

struct Unit {
    let key: String
    let value: Any?
}

extension UIViewController {
    func configureDescriptionBlock(withTitle title: String, andDesctiption description: String) -> UIView? {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.makeRSLabel(withColor: UIColor.rsBlack, andFont: UIFont.robotoBold(ofSize: 24))
        nameLabel.text = title
        
        stack.addArrangedSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor)
        ])
        
        let descriptionLabel = UILabel()
        descriptionLabel.makeRSLabel(withColor: UIColor.rsBlack, andFont: UIFont.robotoRegular(ofSize: 14))
        descriptionLabel.text = description
        descriptionLabel.numberOfLines = 0
        
        stack.addArrangedSubview(descriptionLabel)
        descriptionLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -20).isActive = true
        
        return stack
    }
    
    func configureBlock(withTitle title: String?, andData data: [Unit]) -> UIView? {
        if let title = title {
            let stack = UIStackView()
            stack.spacing = 15
            stack.axis = .vertical
            stack.translatesAutoresizingMaskIntoConstraints = false
            
            let nameLabel = UILabel()
            nameLabel.makeRSLabel(withColor: UIColor.rsBlack, andFont: UIFont.robotoBold(ofSize: 24))
            nameLabel.text = title
            
            stack.addArrangedSubview(nameLabel)
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                nameLabel.topAnchor.constraint(equalTo: stack.topAnchor),
                nameLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor)
            ])
            
            for unit in data {
                if unit.value != nil {
                    let horizontalStack = UIStackView()
                    horizontalStack.axis = .horizontal
                                        horizontalStack.spacing = 10
                    
                    let keyLabel = UILabel()
                    keyLabel.makeRSLabel(withColor: UIColor.rsBlack, andFont: UIFont.robotoBold(ofSize: 14))
                    keyLabel.text = unit.key
                    keyLabel.translatesAutoresizingMaskIntoConstraints = false
                    keyLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
                    
                    let valueLabel = UILabel()
                    valueLabel.makeRSLabel(withColor: UIColor.rsGray, andFont: UIFont.robotoBold(ofSize: 14))
                    valueLabel.text = "\(unit.value!)"
                    
                    if valueLabel.text?.prefix(2) == "-1" || valueLabel.text == "" {
                        continue
                    }
                    
                    if valueLabel.text == "false" {
                        valueLabel.text = "No"
                    } else if valueLabel.text == "true" {
                        valueLabel.text = "Yes"
                    }
                    
                    horizontalStack.addArrangedSubview(keyLabel)
                    horizontalStack.addArrangedSubview(valueLabel)
                    stack.addArrangedSubview(horizontalStack)
                }
            }
            
            return stack
        }
        return nil
    }
}
