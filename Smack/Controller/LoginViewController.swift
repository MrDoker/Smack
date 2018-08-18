//
//  LoginViewController.swift
//  Smack
//
//  Created by DokeR on 18.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: toCreateAccountSegueName, sender: nil)
    }
    
}
