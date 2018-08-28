//
//  ProfileVC.swift
//  Smack
//
//  Created by DokeR on 22.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showUserInfo()
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(closeTapAction))
        bgView.addGestureRecognizer(closeTap)
    }
    
    @objc func closeTapAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: notifUserDataDidChange, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeProfilePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editNameButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Change name", message: "Enter new name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (alertAction) in
            guard let newName = alert.textFields?[0].text else {return}
            AuthService.instance.changeUserName(userID: UserDataService.instance.id, newUserName: newName, completion: { (success) in
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: notifUserDataDidChange, object: nil)
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            })
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) in
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    func showUserInfo() {
        userNameLabel.text = UserDataService.instance.name
        userEmailLabel.text = UserDataService.instance.email
        
        profileImageView.image = UIImage(named: UserDataService.instance.avatarName)
        profileImageView.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
    }
    
}
