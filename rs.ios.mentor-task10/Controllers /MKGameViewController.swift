//
//  MKGameViewController.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 26.08.21.
//

import UIKit

class MKGameViewController: UIViewController {
    var newGameViewController: NewGameViewController?
    
    var scoreStorage = UserDefaults.standard.scoreStorage
    
    //if when extiting timerCounting = false -> timerCounting dolzhen ostat'sya false
    //if when exiting timerCounting = true -> timerCounting = true то есть его тоже бля надо занести в юзердефолтс, шоб он сохранялся...
    
    //какую же хуиту я написал, господь дай мне причину не переписывать заново весь этот кал
    
    var timerCounting = false
    private var startPauseButton = UIImageView(image: UIImage(named: "Play"))
    private var resetButton = UIImageView(image: UIImage(named: "Undo"))
    
    var count = UserDefaults.standard.timerPokasatel
    
    var timer = Timer()
    
    private var nextArrow = UIImageView()
    private var previousArrow = UIImageView()
    
    private var timerLabel = UILabel()
    private var bigDiceImage: UIImageView?
    
    private var mainButton = MKButtonsCollectionViewCell()
    
    var collectionView: MKCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        
        let collectionView = MKCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MKKaruselCollectionViewCell.self, forCellWithReuseIdentifier: "karuselCell")
        collectionView.backgroundColor = .rsBlack
        collectionView.isUserInteractionEnabled = false
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private var letterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MKLetterCollectionViewCell.self, forCellWithReuseIdentifier: "letterCell")
        collectionView.backgroundColor = .rsBlack
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private var buttonsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = UIScreen.main.bounds.width/25
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MKButtonsCollectionViewCell.self, forCellWithReuseIdentifier: "buttonCell")
        collectionView.backgroundColor = .rsBlack
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    func saveScore() {
        let storageData = try! NSKeyedArchiver.archivedData(withRootObject: scoreStorage, requiringSecureCoding: false)
        UserDefaults.standard.set(storageData, forKey: "scoreStorage")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
        self.letterCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView.scrollToItem(at: IndexPath(item: UserDefaults.standard.currentCellIndexPathItem, section: 0), at: .centeredHorizontally, animated: true)
        self.configureLetterColors()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UserDefaults.standard.currentCellIndexPathItem = self.collectionView.indexPath(for: self.collectionView.currentCenterCell!)!.item
    }
    
    func setup() {
        self.view.backgroundColor = .rsBlack
        
        self.configureNavigationBar()
        self.configureControllerName(name: "Game")
        self.configureDicePrikol()
        self.configureTimer()
        self.configureKarusel()
        self.configureArrows()
        self.configureBottomShtuki()
        self.configureLetterColors()
    }
    
    //MARK: Navigation Bar Config
    func configureNavigationBar() {
        let leftButton = self.configureNavBarItem(left: true, text: "NewGame")
        let rightButton = self.configureNavBarItem(left: false, text: "Results")
        
        leftButton.addTarget(self, action: #selector(newGameButtonTouched(sender:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(resultsButtonTouched(sender:)), for: .touchUpInside)
    }
    
    //MARK: Dice Config
    func configureDicePrikol() {
        let diceImage = UIImageView(image: UIImage(named: "dice_4"))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(diceImageTapped(sender:)))
        diceImage.isUserInteractionEnabled = true
        diceImage.addGestureRecognizer(tapGestureRecognizer)
        
        self.view.addSubview(diceImage)
        diceImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            diceImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            diceImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 51),
            
            diceImage.heightAnchor.constraint(equalToConstant: 30),
            diceImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    //MARK: Timer Config
    func configureTimer() {
        self.timerLabel.font = UIFont(name: "Nunito-ExtraBold", size: 28)
        self.timerLabel.textColor = .white
        self.timerLabel.textAlignment = .center
        self.timerLabel.text = timeToString(minutes: secondsToMinutesToSeconds(seconds: UserDefaults.standard.timerPokasatel).0,
                                            seconds: secondsToMinutesToSeconds(seconds: UserDefaults.standard.timerPokasatel).1)
        self.view.addSubview(self.timerLabel)
        self.timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 116),
            timerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            timerLabel.heightAnchor.constraint(equalToConstant: 41),
            timerLabel.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(startPauseButtonTapped(sender:)))
        startPauseButton.isUserInteractionEnabled = true
        startPauseButton.addGestureRecognizer(tapGestureRecognizer)
        
        self.view.addSubview(startPauseButton)
        startPauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startPauseButton.leadingAnchor.constraint(equalTo: self.timerLabel.trailingAnchor, constant: 20),
            startPauseButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 127),
            
            startPauseButton.heightAnchor.constraint(equalToConstant: 20),
            startPauseButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        let tapGestureRecognizerForReset = UITapGestureRecognizer(target: self, action: #selector(resetButtonTouched(sender:)))
        resetButton.isUserInteractionEnabled = true
        resetButton.addGestureRecognizer(tapGestureRecognizerForReset)
        
        self.view.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resetButton.trailingAnchor.constraint(equalTo: self.timerLabel.leadingAnchor, constant: -20),
            resetButton.topAnchor.constraint(equalTo: self.startPauseButton.topAnchor),
            
            resetButton.heightAnchor.constraint(equalToConstant: 20),
            resetButton.widthAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    //MARK: Karusel Config
    func configureKarusel() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.gameDelegate = self
        
        self.view.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.timerLabel.bottomAnchor, constant: 35),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/2.7)
        ])
    }
    
    //MARK: Arrows Config
    func configureArrows() {
        let nextArrow = UIImageView(image: UIImage(named: "icon_Next"))
        let previousArrow = UIImageView(image: UIImage(named: "icon_Previous"))
        let bigNextArrow = UIImageView(image: UIImage(named: "big_Next"))
        let bigPreviousArrow = UIImageView(image: UIImage(named: "big_Previous"))
        
        let nextTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(nextTap(sender:)))
        let previousTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(previousTap(sender:)))
        let toStartTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toStartTap(sender:)))
        let toEndTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toEndTap(sender:)))
        
        nextArrow.addGestureRecognizer(nextTapGestureRecognizer)
        previousArrow.addGestureRecognizer(previousTapGestureRecognizer)
        bigNextArrow.addGestureRecognizer(toEndTapGestureRecognizer)
        bigPreviousArrow.addGestureRecognizer(toStartTapGestureRecognizer)
        
        nextArrow.isUserInteractionEnabled = true
        previousArrow.isUserInteractionEnabled = true
        bigNextArrow.isUserInteractionEnabled = true
        bigPreviousArrow.isUserInteractionEnabled = true
        
        self.view.addSubview(nextArrow)
        self.view.addSubview(previousArrow)
        self.view.addSubview(bigNextArrow)
        self.view.addSubview(bigPreviousArrow)
        
        nextArrow.translatesAutoresizingMaskIntoConstraints = false
        previousArrow.translatesAutoresizingMaskIntoConstraints = false
        bigNextArrow.translatesAutoresizingMaskIntoConstraints = false
        bigPreviousArrow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bigNextArrow.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            bigNextArrow.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -196),
            bigNextArrow.widthAnchor.constraint(equalToConstant: 30),
            bigNextArrow.heightAnchor.constraint(equalToConstant: 30),
            
            bigPreviousArrow.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            bigPreviousArrow.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -196),
            bigPreviousArrow.widthAnchor.constraint(equalToConstant: 30),
            bigPreviousArrow.heightAnchor.constraint(equalToConstant: 30),
            
            nextArrow.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -90),
            nextArrow.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -196),
            nextArrow.widthAnchor.constraint(equalToConstant: 30),
            nextArrow.heightAnchor.constraint(equalToConstant: 30),
            
            previousArrow.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 90),
            previousArrow.centerYAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -196),
            previousArrow.widthAnchor.constraint(equalToConstant: 30),
            previousArrow.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func nextTap(sender: UITapGestureRecognizer) {
        self.collectionView.scrollToNext()
//        print(self.collectionView.currentCenterCell!.assotiatedPlayer!.name)
        self.configureLetterColors()
    }
    
    @objc func previousTap(sender: UITapGestureRecognizer) {
        self.collectionView.scrollToPrevious()
        self.configureLetterColors()
    }
    
    @objc func toStartTap(sender: UITapGestureRecognizer) {
        self.collectionView.scrollToStart()
        self.configureLetterColors()
    }
    
    @objc func toEndTap(sender: UITapGestureRecognizer) {
        self.collectionView.scrollToEnd()
        self.configureLetterColors()
    }
    
    //MARK: Bottom Prikoly config
    func configureBottomShtuki() {
        //MARK: Reset label
        let resetLabel = UIImageView(image: UIImage(named: "Undo"))
        let resetGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resetLabelTouched(sender:)))
        resetLabel.addGestureRecognizer(resetGestureRecognizer)
        resetLabel.isUserInteractionEnabled = true
        
        self.view.addSubview(resetLabel)
        resetLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resetLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            resetLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -32),
            
            resetLabel.heightAnchor.constraint(equalToConstant: 20),
            resetLabel.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        //MARK: MainButton
        mainButton.digit = 1
        mainButton.configureCell()
        mainButton.clipsToBounds = false
        mainButton.layer.cornerRadius = self.view.frame.height/(9*2) //ПАЧИМУ НА БОЛЬШИХ ЭКРАНАХ ОНО НЕ КРУГЛИТ КНОПКУ ЕБУЧУЮ
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mainButtonTouched(sender:)))
        mainButton.addGestureRecognizer(tapGestureRecognizer)
        
        self.view.addSubview(mainButton)
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -151),
            mainButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            mainButton.heightAnchor.constraint(equalToConstant: self.view.frame.height/9),
            mainButton.widthAnchor.constraint(equalToConstant: self.view.frame.height/9)
        ])
        
        //MARK: ButtonsCollectionView
        self.buttonsCollectionView.delegate = self
        self.buttonsCollectionView.dataSource = self
        
        self.view.addSubview(buttonsCollectionView)
        self.buttonsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.buttonsCollectionView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -135),
            self.buttonsCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -74),
            self.buttonsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.buttonsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        //MARK: LetterCollectionView
        self.letterCollectionView.delegate = self
        self.letterCollectionView.dataSource = self
        
        self.view.addSubview(self.letterCollectionView)
        self.letterCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.letterCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            self.letterCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 80),
            self.letterCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -80),
            self.letterCollectionView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -54)
        ])
    }
    
    //MARK: Letter collection coloring
    func configureLetterColors() {
        for case let letterCell as MKLetterCollectionViewCell in self.letterCollectionView.visibleCells {
            if let currentCell = self.collectionView.currentCenterCell {
                if letterCell.assosiatedPlayer == currentCell.assotiatedPlayer {
                    letterCell.performMagic(check: true)
                } else {
                    letterCell.performMagic(check: false)
                }
            }
        }
    }
    
    //MARK: Actions
    @objc func mainButtonTouched(sender: UITapGestureRecognizer) {
        let currentCell = self.collectionView.currentCenterCell
        currentCell?.changeScore(with: 1)
        self.collectionView.scrollToNext()
        self.collectionView.reloadData()
    }
    
    //MARK: Timer
    @objc func resetLabelTouched(sender: UITapGestureRecognizer) {
        if let lastScoreKeeper = self.scoreStorage.last {
            if let resetScore = Int(lastScoreKeeper.score) {
                for player in self.newGameViewController!.storage {
                    if player.name == scoreStorage.last?.name {
                        player.score = String(Int(player.score)! - resetScore)
                        self.newGameViewController?.saveData()
                        scoreStorage.removeLast()
                        self.saveScore()
                    }
                }
                self.collectionView.scrollToPrevious()
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func startPauseButtonTapped(sender: UITapGestureRecognizer) {
        if self.timerCounting {
            timerCounting = false
            startPauseButton.image = UIImage(named: "Play")
            timer.invalidate()
        } else {
            timerCounting = true
            startPauseButton.image = UIImage(named: "Pause")
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerIsCounting(sender:)), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: .common)
        }
    }
    
    @objc func resetButtonTouched(sender: UITapGestureRecognizer) {
        self.count = 0
        timerCounting = false
        startPauseButton.image = UIImage(named: "Play")
        self.timerLabel.text = "00:00"
        timer.invalidate()
    }
    
    @objc func timerIsCounting(sender: Timer) {
        count = count + 1
        let time = secondsToMinutesToSeconds(seconds: count)
        let timeString = timeToString(minutes: time.0, seconds: time.1)
        self.timerLabel.text = timeString
    }
    
    func secondsToMinutesToSeconds(seconds: Int) -> (Int, Int) {
        return ((seconds/60), (seconds%60))
    }
    
    func timeToString(minutes: Int, seconds: Int) -> String {
        var string = ""
        string += String(format: "%02d", minutes)
        string += ":"
        string += String(format: "%02d", seconds)
        
        return string
    }
    
    //MARK: Dice image tap
    @objc func diceImageTapped(sender: UITapGestureRecognizer) {
        for view in self.view.subviews {
            if view.isKind(of: UIImageView.self) {
                let imageView = view as! UIImageView
                if imageView.image == UIImage(named: "dice_4") {
                    self.view.willRemoveSubview(imageView)
                    imageView.removeFromSuperview()
                }
            }
        }
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let visualEffectsView = UIVisualEffectView(effect: blurEffect)
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(screenTouchedWhenDiceImageAtTop(sender:)))
        visualEffectsView.addGestureRecognizer(tapGestureRecognizer)
        
        self.view.addSubview(visualEffectsView)
        visualEffectsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            visualEffectsView.topAnchor.constraint(equalTo: self.view.topAnchor),
            visualEffectsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            visualEffectsView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            visualEffectsView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
        
        self.bigDiceImage = UIImageView(image: UIImage(named: String(format: "dice_%d", Int.random(in: 1...6))))
        
        animate(in: true, sender: bigDiceImage!)
        bigDiceImage!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bigDiceImage!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            bigDiceImage!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            bigDiceImage!.heightAnchor.constraint(equalToConstant: 120),
            bigDiceImage!.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    @objc func screenTouchedWhenDiceImageAtTop(sender: UITapGestureRecognizer) {
        self.animate(in: false, sender: sender.view!)
        self.bigDiceImage?.removeFromSuperview()
        self.configureDicePrikol()
    }
    
    func animate(in check: Bool, sender: UIView) {
        if check {
            self.view.addSubview(sender)
            
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            sender.alpha = 0
            
            UIView.animate(withDuration: 0.5, animations: {
                sender.transform = CGAffineTransform(scaleX: 1, y: 1)
                sender.alpha = 1
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                sender.removeFromSuperview()
            })
        }
    }
    
    //MARK: NAvBar touches
    @objc func newGameButtonTouched(sender: UIBarButtonItem) {
        self.newGameViewController?.isFirstTimePresenting = false
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func resultsButtonTouched(sender: UIBarButtonItem) {
        let resultsController = MKResultsControllerViewController()
        resultsController.delegate = self
        
        self.navigationController?.pushViewController(resultsController, animated: true)
    }
}

extension MKGameViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.buttonsCollectionView {
            return 5
        }
        return (self.newGameViewController?.storage.count)!-1
    }
    
    //MARK: Cell config
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "karuselCell", for: indexPath) as! MKKaruselCollectionViewCell
            cell.configureCell(player: (self.newGameViewController?.storage[indexPath.row])!)
            cell.delegate = self
            
            return cell
        } else if collectionView == self.letterCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "letterCell", for: indexPath) as! MKLetterCollectionViewCell
            cell.backgroundColor = .rsBlack
            cell.collectionView = self.collectionView
            cell.configureCell(player: (self.newGameViewController?.storage[indexPath.row])!)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath) as! MKButtonsCollectionViewCell
            cell.collectionView = self.collectionView
            
            switch indexPath.row {
            case 0:
                cell.digit = -10
                cell.configureCell()
            case 1:
                cell.digit = -5
                cell.configureCell()
            case 2:
                cell.digit = -1
                cell.configureCell()
            case 3:
                cell.digit = +5
                cell.configureCell()
            case 4:
                cell.digit = +10
                cell.configureCell()
            default:
                break
            }
            
            return cell
        }
    }
    
    
    //MARK: Cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView === self.collectionView {
            return CGSize(width: self.collectionView.frame.width/1.65, height: self.collectionView.frame.height)
        } else if collectionView == self.letterCollectionView {
            return CGSize(width: 20, height: 24)
        } else {
            return CGSize(width: self.view.frame.width/6.818, height: self.view.frame.width/6.818)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.letterCollectionView {
            let totalCellWidth = 20 * ((self.newGameViewController?.storage.count)!-1)
            let totalSpacingWidth = 5 * ((self.newGameViewController?.storage.count)!-1-1)
            
            let leftInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
            let rightInset = leftInset
            
            return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        } else if collectionView == self.collectionView {
            return UIEdgeInsets(top: 0,
                                left: self.view.frame.width/2-self.collectionView.frame.width/(1.65*2),
                                bottom: 0,
                                right: self.view.frame.width/2-self.collectionView.frame.width/(1.65*2))
        } else {
            return UIEdgeInsets(top: 0, left: self.view.frame.width/18.75, bottom: 0, right: self.view.frame.width/18.75)
        }
    }
}

//MARK: Scrolling extension
extension MKCollectionView {
    open var currentCenterCell: MKKaruselCollectionViewCell? {
        let visibleRect = CGRect(origin: self.contentOffset, size: self.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let visibleIndexPath = self.indexPathForItem(at: visiblePoint) {
            return self.cellForItem(at: visibleIndexPath) as? MKKaruselCollectionViewCell
        }
        
        return nil
    }
    
    func scrollToNext() {
        guard (self.gameDelegate?.newGameViewController?.storage.count)! > 2 else { return }
        
        let visibleItems = self.indexPathsForVisibleItems
        var currentItem = visibleItems.sorted().first
        if visibleItems.count == 3 {
            currentItem = visibleItems.sorted()[1]
        }
        
        var nextItem = IndexPath()
        if let currentItem = currentItem {
            if let nextItemCell = self.cellForItem(at: IndexPath(item: currentItem.item+1, section: 0)) {
                if let indexPathForNextCell = self.indexPath(for: nextItemCell) {
                    nextItem = indexPathForNextCell
                }
            }
        }
        
        if let currentCenterCell = self.currentCenterCell {
            if nextItem == self.indexPath(for: currentCenterCell) {
                self.scrollToStart()
                return
            }
        }
        
        self.scrollToItem(at: nextItem, at: .centeredHorizontally, animated: true)
    }
    
    func scrollToPrevious() {
        guard (self.gameDelegate?.newGameViewController?.storage.count)! > 2 else { return }
        
        let visibleItems = self.indexPathsForVisibleItems
        var currentItem = visibleItems.sorted().last
        if visibleItems.count == 3 {
            currentItem = visibleItems.sorted()[1]
        }
        
        var previousItem = IndexPath()
        if let currentItem = currentItem {
            if let previousItemCell = self.cellForItem(at: IndexPath(item: currentItem.item-1, section: 0)) {
                if let indexPathForNextCell = self.indexPath(for: previousItemCell) {
                    previousItem = indexPathForNextCell
                }
            }
        }
        
        if let currentCenterCell = self.currentCenterCell {
            if previousItem == self.indexPath(for: currentCenterCell) {
                self.scrollToEnd()
                return
            }
        }
        
        self.scrollToItem(at: previousItem, at: .centeredHorizontally, animated: true)
    }
    
    func scrollToStart() {
        self.self.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func scrollToEnd() {
        let lastRow = self.numberOfItems(inSection: 0)
        self.self.scrollToItem(at: IndexPath(row: lastRow - 1, section: 0), at: .centeredHorizontally, animated: true)
    }
}
