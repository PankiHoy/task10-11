//
//  MKDetailedLaunchesViewController.swift
//  rs.ios.stage-task11
//
//  Created by dev on 15.09.21.
//

import UIKit

class MKLaunchesDetailedViewController: UIViewController {
    var launch: MKLaunch?
    var cover: UIImage?
    
    weak var delegate: MKRocketsViewController?
    
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
    
    init(withLaunch launch: MKLaunch, andCover cover: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        self.launch = launch
        self.cover = cover
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        configureNavBar()
        configureScrollView()
        configureCover()
        configureStackView()
    }
    
    func configureNavBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.rsCoral
        self.title = "\(launch?.name ?? "")"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.rsWhite,
            NSAttributedString.Key.font: UIFont.robotoBold(ofSize: 24)
        ]
    }
    
    func configureCover() {
        let coverView = UIView()
        
        //MARK: - Name label
        let nameLabel = UILabel()
        nameLabel.makeRSLabel(withColor: UIColor.rsBlack, andFont: UIFont.robotoBold(ofSize: 24))
        nameLabel.text = launch?.name
        
        coverView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: coverView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: coverView.leadingAnchor)
        ])
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let date = formatter.date(from: launch!.dateUTC)
        formatter.dateFormat = "MMMM dd, yyyy"
        
        //MARK: - Date label
        let dateLabel = UILabel()
        dateLabel.makeRSLabel(withColor: UIColor.rsBlack, andFont: UIFont.robotoBold(ofSize: 17))
        dateLabel.text = formatter.string(from: date!)
        
        coverView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: coverView.topAnchor, constant: 37),
            dateLabel.leadingAnchor.constraint(equalTo: coverView.leadingAnchor)
        ])
        
        //MARK: - Success label
        let successLabel = UIImageView()
        if launch!.upcoming {
            successLabel.image = UIImage.rsUpcoming
        } else {
            successLabel.image = UIImage.rsCompleted
        }
        
        coverView.addSubview(successLabel)
        successLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            successLabel.leadingAnchor.constraint(equalTo: coverView.leadingAnchor),
            successLabel.topAnchor.constraint(equalTo: coverView.topAnchor, constant: 72)
        ])
        
        //MARK: - Number label
        let numberLabel = ShadowedView()
        numberLabel.layer.cornerRadius = 16
        
        let number = UILabel()
        number.makeRSLabel(withColor: UIColor.rsCyan, andFont: UIFont.robotoBold(ofSize: 17))
        number.text = "#\(launch?.flightNumber ?? 0)"
        number.textAlignment = .center
        
        numberLabel.addSubview(number)
        number.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            number.topAnchor.constraint(equalTo: numberLabel.topAnchor, constant: 5),
            number.leadingAnchor.constraint(equalTo: numberLabel.leadingAnchor, constant: 10),
            number.trailingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: -10),
            number.bottomAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: -5)
        ])
        
        coverView.addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: coverView.topAnchor, constant: 76),
            numberLabel.leadingAnchor.constraint(equalTo: coverView.leadingAnchor, constant: 42),
            numberLabel.heightAnchor.constraint(equalToConstant: 32),
            numberLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 59)
        ])
        
        //MARK: - Image Label
        let imageLabel = ShadowedView()
        imageLabel.layer.cornerRadius = 20
        imageLabel.contentMode = .scaleToFill
        
        if (cover != nil) && cover != UIImage.rsPlaceholder {
            imageView.image = cover
        } else {
            imageView.image = UIImage.rsPlaceholder
            
            DispatchQueue.global().async { [weak self] in
                URLSession.shared.dataTask(with: (self?.launch?.links.patch.small)!) { data, _, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: data!)
                    }
                }.resume()
            }
        }
        
        imageLabel.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: imageLabel.topAnchor, constant: 15),
            imageView.leadingAnchor.constraint(equalTo: imageLabel.leadingAnchor, constant: 9.5),
            imageView.trailingAnchor.constraint(equalTo: imageLabel.trailingAnchor, constant: -9.5),
            imageView.bottomAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: -15)
        ])
        
        coverView.addSubview(imageLabel)
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageLabel.topAnchor.constraint(equalTo: coverView.topAnchor),
            imageLabel.trailingAnchor.constraint(equalTo: coverView.trailingAnchor),
            imageLabel.heightAnchor.constraint(equalToConstant: 110),
            imageLabel.widthAnchor.constraint(equalToConstant: 110)
        ])
        
        contentView.addSubview(coverView)
        coverView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coverView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            coverView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            coverView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            coverView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40)
        ])
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
    
    func configureStackView() {
        if let description = launch?.details {
            stackView.addArrangedSubview(configureDescriptionBlock(withTitle: "Description", andDesctiption: description)!)
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        var fireDateString = ""
        if let data = launch?.staticFireDateUtc {
            let date = formatter.date(from: data)
            formatter.dateFormat = "MMMM dd, yyyy"
            if let date = date {
                fireDateString = formatter.string(from: date)
            }
        }
        
        var utcDateString = ""
        if let dataUTC = launch?.dateUTC {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            let date = formatter.date(from: dataUTC)
            formatter.dateFormat = "MMMM dd, yyyy"
            if let date = date {
                utcDateString = formatter.string(from: date)
            }
        }
        
        stackView.addArrangedSubview(configureBlock(withTitle: "Overview", andData: [
            Unit(key: "Static fire date", value: fireDateString),
            Unit(key: "Launch date", value: utcDateString),
            Unit(key: "Success", value: launch?.success)
        ])!)
        
        if (launch?.links.flickrImages.original.count)! > 0 {
            stackView.addArrangedSubview(configureImageCollectionBlock())
        }
        
        stackView.addArrangedSubview(configureRocketBlock())
        
        stackView.addArrangedSubview(configureMaterialsBlock(withTitle: "Materials", andMaterials: [
            "Wikipedia": launch?.links.wikipedia,
            "Youtube": launch?.links.webcast
        ]))
        
        
        
        let array = [launch?.links.reddit.campaign, launch?.links.reddit.launch, launch?.links.reddit.recovery, launch?.links.reddit.recovery]
        if array.filter({ $0 == nil }).count < array.count {
            stackView.addArrangedSubview(configureMaterialsBlock(withTitle: "Reddit", andMaterials: [
                "Recovery": launch?.links.reddit.recovery,
                "Campaign": launch?.links.reddit.campaign,
                "Media": launch?.links.reddit.media,
                "Launch": launch?.links.reddit.launch
            ]))
        }
    }
    
    func configureRocketBlock() -> UIView {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.makeRSLabel(withColor: UIColor.rsBlack, andFont: UIFont.robotoBold(ofSize: 24))
        nameLabel.text = "Rocket"
        
        stack.addArrangedSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: stack.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor)
        ])
        
        let rocketCell = getRocketCellFromURL(url: URL(string: "https://api.spacexdata.com/v4/rockets/\(launch?.rocket ?? "")")!)
        
//        rocketCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showRocket(sender:))))
//        rocketCell.isUserInteractionEnabled = true
        
        stack.addArrangedSubview(rocketCell)
        rocketCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rocketCell.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            rocketCell.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -20),
            rocketCell.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
        
        return stack
    }
    
    func configureMaterialsBlock(withTitle title: String, andMaterials materials: [String: URL?]) -> UIView {
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
        
        let horStack = UIStackView()
        horStack.spacing = 20
        horStack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        for (key, url) in materials {
            if url != nil && url != URL(string: "") {
                let label = ShadowedView()
                label.makeRSMaterialsLabel(withTitle: key)
                label.material = url
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(accessMaterial(sender:)))
                label.addGestureRecognizer(tap)
                
                horStack.addArrangedSubview(label)
                label.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    label.widthAnchor.constraint(equalToConstant: 117),
                    label.heightAnchor.constraint(equalToConstant: 32),
                ])
            }
        }
        
        stack.addArrangedSubview(horStack)
        stack.alignment = .leading
        
        return stack
    }
    
    @objc func showRocket(sender: AnyObject) {
        let rocket = getRocket(url: URL(string: "https://api.spacexdata.com/v4/rockets/\(launch?.rocket ?? "")")!)
        let cover = try! UIImage(data: Data(contentsOf: rocket.flickrImages.last!))
        self.navigationController?.pushViewController(MKRocketsDetailedViewController(withLaunch: rocket, andCover: cover), animated: true)
    }
    
    @objc func accessMaterial(sender: UITapGestureRecognizer) {
        let materialView = sender.view as! ShadowedView
        
        let webC = MKWebViewController(withURL: materialView.material!)
        self.navigationController?.present(webC, animated: true, completion: nil)
    }
    
    func getRocketCellFromURL(url: URL) -> MKRocketsCollectionViewCell {
        let rocketCell = MKRocketsCollectionViewCell()
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url) { data, _, error in
                do {
                    let rocket = try JSONDecoder().decode(MKRocket.self, from: data!)
                    DispatchQueue.main.async {
                        rocketCell.configureCell(withRocket: rocket)
                        rocketCell.imageView.downloaded(from: rocket.flickrImages.last!, contentMode: .scaleAspectFill)
                    }
                } catch {
                    print(error)
                    return
                }
            }.resume()
        }
        
        return rocketCell
    }
    
    //TODO: - this thing
    func getRocket(url: URL) -> MKRocket {
        var raketa: MKRocket?
        
            URLSession.shared.dataTask(with: url) { data, _, error in
                do {
                    let rocket = try JSONDecoder().decode(MKRocket.self, from: data!)
                    raketa = rocket
                } catch {
                    print(error)
                    return
                }
            }.resume()
        
        return raketa!
    }
}

extension MKLaunchesDetailedViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launch?.links.flickrImages.original.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MKImageCollectionViewCell.identifier, for: indexPath) as! MKImageCollectionViewCell
        cell.delegate = self
        cell.configureCell()
        cell.imageView.downloaded(from: (self.launch?.links.flickrImages.original[indexPath.row])!, contentMode: .scaleAspectFill)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 145, height: 196)
    }
}
