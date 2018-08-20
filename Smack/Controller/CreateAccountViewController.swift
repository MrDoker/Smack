//
//  CreateAccountViewController.swift
//  Smack
//
//  Created by DokeR on 19.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: unwindToChannel, sender: nil)
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailTextField.text, emailTextField.text != ""
            else { return }
        guard let password = passwordTextField.text, passwordTextField.text != ""
            else { return }
        guard let name = userNameTextField.text, userNameTextField.text != ""
            else { return }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.performSegue(withIdentifier: unwindToChannel, sender: nil)
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                            }
                        })
                    }
                })
            }
        }
    }

    @IBAction func pickAvatarPressed(_ sender: Any) {
        
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        
    }
    
}

extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }  
}















