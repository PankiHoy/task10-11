//
//  NewGameViewController.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 25.08.21.
//

import UIKit

//First launch or newGame: isFirstTimePresenting = true

class NewGameViewController: UIViewController {
    var gameViewController: MKGameViewController?
    var addPlayerViewController: AddPlayerViewController?
    
    var isFirstTimePresenting = true
    
    var startGameButton = UIButton()

    var cancelButton = RSBarButtonItem(withText: "Cancel")
    
    var storage = UserDefaults.standard.storage
    
    lazy var tableView: MKTableView = {
        let tableView = MKTableView()
        tableView.separatorColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
        tableView.backgroundColor = .rsGray
        tableView.layer.cornerRadius = 15
        
        return tableView
    }()
    
    func saveData() {
        let storageData = try! NSKeyedArchiver.archivedData(withRootObject: storage, requiringSecureCoding: false)
        UserDefaults.standard.set(storageData, forKey: "storage")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        
        if isFirstTimePresenting {
            cancelButton.isHidden = true
        } else {
            cancelButton.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    func setup() {
        self.configureNavigationBar()
        self.configureControllerName(name: "Game Counter")
        self.configureTableView()
        self.configureStartButton()
        self.tableView.reloadData()
    }
    
    func configureNavigationBar() {
        self.cancelButton = self.configureNavBarItem(left: true, text: "Cancel")
        self.cancelButton.addTarget(self, action: #selector(cancelButtonPressed(sender:)), for: .touchUpInside)
    }
    
    func configureTableView() {
        self.tableView.register(MKTableViewCell.self, forCellReuseIdentifier: "playersCell")
        self.tableView.register(MKTableViewHeader.self, forHeaderFooterViewReuseIdentifier: MKTableViewHeader.identifier)
        self.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "footer")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isEditing = true
        
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 112)
        ])
    }
    
    func configureStartButton() {
        self.startGameButton = UIButton()
        startGameButton.addTarget(self, action: #selector(startGameButtonTouched(sender:)), for: .touchUpInside)
//        let startGameButtonInnerShadow = UIButton()
        
        startGameButton.backgroundColor = .rsGreen
        startGameButton.clipsToBounds = false
        startGameButton.layer.cornerRadius = 32.5
        
        startGameButton.layer.shadowColor = UIColor.rsDarkGreen.cgColor
        startGameButton.layer.shadowOffset = .init(width: 0, height: 5)
        startGameButton.layer.shadowOpacity = 1
        startGameButton.layer.shadowRadius = 0
        startGameButton.layer.cornerRadius = 32.5
        
        let buttonTitle = UILabel()
        buttonTitle.text = "Start Game"
        buttonTitle.font = UIFont(name: "Nunito-ExtraBold", size: 24)
        buttonTitle.textColor = .white

        buttonTitle.layer.shadowColor = UIColor.rsDarkGreen.cgColor
        buttonTitle.layer.shadowOffset = .init(width: 0, height: 2)
        buttonTitle.layer.shadowOpacity = 1
        buttonTitle.layer.shadowRadius = 0
        
//        let titleShadow = UILabel()
//        titleShadow.text = "Start Game"
//        titleShadow.font = UIFont(name: "Nunito-ExtraBold", size: 24)
//        titleShadow.textColor = .rsDarkGreen
        
        startGameButton.addSubview(buttonTitle)
//        startGameButton.addSubview(titleShadow)
        
        startGameButton.bringSubviewToFront(buttonTitle)
        
        buttonTitle.translatesAutoresizingMaskIntoConstraints = false
//        titleShadow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonTitle.centerXAnchor.constraint(equalTo: startGameButton.centerXAnchor),
            buttonTitle.centerYAnchor.constraint(equalTo: startGameButton.centerYAnchor),
            
//            titleShadow.centerXAnchor.constraint(equalTo: buttonTitle.centerXAnchor),
//            titleShadow.centerYAnchor.constraint(equalTo: buttonTitle.centerYAnchor, constant: 2)
        ])
        
//        startGameButtonInnerShadow.backgroundColor = .rsDarkGreen
//        startGameButtonInnerShadow.clipsToBounds = false
//        startGameButtonInnerShadow.layer.cornerRadius = 32.5
        
        self.view.addSubview(startGameButton)
//        self.view.addSubview(startGameButtonInnerShadow)
        
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
//        startGameButtonInnerShadow.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startGameButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -65),
            startGameButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            startGameButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            startGameButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
//        NSLayoutConstraint.activate([
//            startGameButtonInnerShadow.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60),
//            startGameButtonInnerShadow.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
//            startGameButtonInnerShadow.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
//
//            startGameButtonInnerShadow.heightAnchor.constraint(equalToConstant: 65)
//        ])
        
        self.view.bringSubviewToFront(startGameButton)
        
    }
    
    @objc func cancelButtonPressed(sender: UIBarButtonItem) {
        self.navigationController?.pushViewController(self.gameViewController!, animated: true)
    }
    
    @objc func startGameButtonTouched(sender: UIButton) {
        guard storage.count > 1 else {
            let alertContoller = UIAlertController(title: "Error", message: "Ты вообще ебач, игроков то добавь roflanDodik", preferredStyle: .actionSheet)
            alertContoller.addAction(UIAlertAction(title: "ладно.", style: .destructive, handler: {_ in
                print("vsem ku")
            }))
            alertContoller.view.backgroundColor = .rsDarkGray
            
            present(alertContoller, animated: true)
            
            return
        }
        
        self.startNewGame()
        UserDefaults.standard.firstTimeLaunchCheck = false
        
        self.navigationController?.pushViewController(self.gameViewController!, animated: true)
    }
    
    func reloadScore() {
        for player in self.storage {
            player.score = String(0)
        }
        self.saveData()
    }
    
    func reloadCurrentPlayer() {
        UserDefaults.standard.currentCellIndexPathItem = 0
    }
    
    func reloadTimer() {
        UserDefaults.standard.timerPokasatel = 0
    }
    
    @objc func startNewGame() {
        UserDefaults.standard.firstTimeLaunchCheck = true
        self.isFirstTimePresenting = true
        self.reloadScore()
        self.reloadCurrentPlayer()
        self.gameViewController?.scoreStorage = [] //Why setter isn't working? and i have to call saveScore
        self.gameViewController?.saveScore()
        self.gameViewController!.resetButtonTouched(sender: UITapGestureRecognizer())
    }
}

extension NewGameViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.textLabel?.text == "Add player" {
            cell.textLabel?.textColor = .rsGreen
            cell.textLabel?.font = UIFont(name: "Nunito-SemiBold", size: 16)
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        } else {
            cell.textLabel?.font = UIFont(name: "Nunito-ExtraBold", size: 20)
            cell.textLabel?.textColor = .white
        }
    }
    
    //MARK: Cell config
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playersCell", for: indexPath) as! MKTableViewCell
        
        if indexPath.item == storage.count-1  {
            cell.textLabel?.text = "Add player"
        } else {
            cell.textLabel?.text = storage[indexPath.item].name
        }
        
        return cell
    }
    
    //MARK: Editing style plushki
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if storage[indexPath.item].name == "prikol" {
            return .insert
        }
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if storage[indexPath.item].name == "prikol" {
            return false
        }
        
        return true
    }
    
    //MARK: Header and Footer config
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MKTableViewHeader.identifier) as? MKTableViewHeader
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .rsGray
        
        header?.backgroundView = backgroundView
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer")
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .rsGray
        
        header?.backgroundView = backgroundView
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    //MARK: Moving cell
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObj = storage[sourceIndexPath.item]
        storage.remove(at: sourceIndexPath.item)
        storage.insert(movedObj, at: destinationIndexPath.item)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if(proposedDestinationIndexPath.row == storage.count-1)
        {
            return tableView.indexPath(for: tableView.cellForRow(at: IndexPath(row: proposedDestinationIndexPath.row-1, section: proposedDestinationIndexPath.section))!)!
        }
        
        return proposedDestinationIndexPath
    }
    
    //MARK: Adding and Deleting Cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .insert {
            self.addPlayerViewController = AddPlayerViewController()
            self.addPlayerViewController?.delegate = self
            self.navigationController?.pushViewController(self.addPlayerViewController!, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let button = UITableViewRowAction(style: .default, title: "Delete", handler: {_,_ in
            self.storage.remove(at: indexPath.item)
            self.saveData()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.reloadData()
        })
        button.backgroundColor = .rsRed
        
        return [button]
    }
}

extension UIViewController {
    func configureControllerName(name: String) {
        let controllerNameLabel = MKControllerNameLabel(withName: name)
        
        self.view.addSubview(controllerNameLabel)
        controllerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            controllerNameLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20.0),
            controllerNameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 46)
        ])
    }
    
    func configureNavBarItem(left: Bool, text: String) -> RSBarButtonItem {
        let button = RSBarButtonItem(withText: text)
        button.titleLabel?.textColor = .rsGreen
        
        button.addTarget(self, action: #selector(buttonCancelled(sender:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUp(sender:)), for: .touchUpInside)
        
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if left {
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                
                button.heightAnchor.constraint(equalToConstant: 41)
            ])
        } else {
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                
                button.heightAnchor.constraint(equalToConstant: 41)
            ])
        }
        
        return button
    }
    
    @objc func buttonCancelled(sender: RSBarButtonItem) {
        sender.isHighlighted(true)
    }
    
    
    @objc func buttonTouchUp(sender: RSBarButtonItem) {
        sender.isHighlighted(false)
    }
}
