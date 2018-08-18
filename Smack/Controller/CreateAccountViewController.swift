//
//  CreateAccountViewController.swift
//  Smack
//
//  Created by DokeR on 19.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: unwindToChannel, sender: nil)
    }
    
}
