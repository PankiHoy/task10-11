//
//  AddPlayerViewController.swift
//  rs.ios.mentor-task10
//
//  Created by dev on 26.08.21.
//

import UIKit

class AddPlayerViewController: UIViewController {
    weak var delegate: NewGameViewController?
    
    private var addButton: RSBarButtonItem?
    
    var textField: UITextField = {
        let textField = TextFieldWithPadding()
        textField.layer.backgroundColor = UIColor.rsGray.cgColor
        textField.attributedPlaceholder = NSAttributedString(string: "Player Name",
                                                             attributes: [NSAttributedString.Key.foregroundColor:
                                                                            UIColor(red: 0.608, green: 0.608, blue: 0.631, alpha: 1)])
        textField.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        textField.textColor = .white
        textField.autocorrectionType = .no

        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    func setup() {
        self.view.backgroundColor = .rsBlack
        
        self.configureControllerName(name: "Add player")
        self.configureNavigationBar()
        self.configureTextField()
    }
    
    func configureNavigationBar() {
        let leftButton = self.configureNavBarItem(left: true, text: "Back")
        self.addButton = self.configureNavBarItem(left: false, text: "Add")
        
        self.addButton?.isEnabled = false
        self.addButton?.isHighlighted(true)
        
        leftButton.addTarget(self, action: #selector(backToRoots(sender:)), for: .touchUpInside)
        self.addButton?.addTarget(self, action: #selector(addPlayer(sender:)), for: .touchUpInside)
    }
    
    func configureTextField() {
        self.view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textChanged(sender:)), for: .editingChanged)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 112),
            textField.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    
    @objc func backToRoots(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func addPlayer(sender: UIBarButtonItem) {
        self.delegate?.storage.insert(MKPlayer(withName: textField.text!, and: 0), at: (self.delegate?.storage.count)!-1)
        self.delegate?.tableView.reloadData()
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func textChanged(sender: UITextField) {
        if sender.text?.isEmpty == true {
            self.addButton?.isEnabled = false
            self.addButton?.isHighlighted(true)
        } else {
            self.addButton?.isEnabled = true
            self.addButton?.isHighlighted(false)
        }
    }
    
}

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(
        top: 18,
        left: 24,
        bottom: 18,
        right: 0
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
