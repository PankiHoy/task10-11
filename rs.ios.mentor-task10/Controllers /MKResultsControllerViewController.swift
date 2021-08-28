//
//  MKResultsControllerViewController.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 27.08.21.
//

import UIKit

class MKResultsControllerViewController: UIViewController {
    var delegate: MKGameViewController?
    
    private var highScore: Array<MKPlayer> {
        return calculateFirstThreePretendents()
    }
    
    var tableView: MKTableView = {
        let tableView = MKTableView()
        tableView.backgroundColor = .rsBlack
        tableView.separatorColor = .rsBlack
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        return tableView
    }()
    
    var turnsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .rsGray
        tableView.separatorColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
        tableView.layer.cornerRadius = 15
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        turnsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    func setup() {
        self.view.backgroundColor = .rsBlack
        
        self.configureNavBar()
        self.configureControllerName(name: "Results")
        self.configureHighscoreTableView()
        self.configureTurnsTableView()
        tableView.reloadData()
        turnsTableView.reloadData()
    }
    
    func configureNavBar() {
        let leftButton = self.configureNavBarItem(left: true, text: "New Game")
        let rightButton = self.configureNavBarItem(left: false, text: "Resume")
        
        leftButton.addTarget(self, action: #selector(newGameButtonTouched(sender:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(resumeButtonTouched(sender:)), for: .touchUpInside)
    }
    
    func configureHighscoreTableView() {
        tableView.register(MKHighscoreTableViewCell.self, forCellReuseIdentifier: MKHighscoreTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isUserInteractionEnabled = false
        tableView.sizeToFit()
        tableView.separatorColor = UIColor(named: "RSBlack")
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 105),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func configureTurnsTableView() {
        turnsTableView.register(MKTurnsTableViewCell.self, forCellReuseIdentifier: MKTurnsTableViewCell.identifier)
        turnsTableView.register(MKTableViewHeader.self, forHeaderFooterViewReuseIdentifier: MKTableViewHeader.identifier)
        turnsTableView.delegate = self
        turnsTableView.dataSource = self
        turnsTableView.isUserInteractionEnabled = false
        
        self.view.addSubview(turnsTableView)
        turnsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            turnsTableView.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 10),
            turnsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            turnsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            turnsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20)
        ])
        
    }
    
    
    @objc func newGameButtonTouched(sender: UIButton) {
        self.delegate?.newGameViewController?.startNewGame()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func resumeButtonTouched(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func calculateFirstThreePretendents() -> Array<MKPlayer> {
        var storage: Array<MKPlayer> = []
        for item in delegate!.newGameViewController!.storage {
            guard item.name != "prikol" else { break }
            storage.append(item)
        }
        let highscore = Array(storage.sorted(by: {$0.score > $1.score }).prefix(3))
        
        return highscore
    }
    
}

extension MKResultsControllerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return self.highScore.count
        } else {
            return (self.delegate?.scoreStorage.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height/14.75
    }
    
    //MARK: Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == self.turnsTableView {
            let header = self.turnsTableView.dequeueReusableHeaderFooterView(withIdentifier: MKTableViewHeader.identifier) as? MKTableViewHeader
            header?.label.text = "Turns"
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .rsGray
            
            header?.backgroundView = backgroundView
            
            return header
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.turnsTableView {
            return self.view.frame.height/18.95
        } else {
            return 0
        }
    }

    //MARK: Cell config
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: MKHighscoreTableViewCell.identifier) as! MKHighscoreTableViewCell
            cell.delegate = self
            cell.configureCell(withText: self.highScore[indexPath.item].name,
                               place: indexPath.row+1,
                               and: self.highScore[indexPath.item].score)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MKTurnsTableViewCell.identifier) as! MKTurnsTableViewCell
            cell.configureCell(withScore: (self.delegate?.scoreStorage.reversed()[indexPath.item])!)
            
            return cell
        }
    }
    
    
    
}
