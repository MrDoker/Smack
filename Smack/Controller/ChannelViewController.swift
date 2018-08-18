//
//  ChannelViewController.swift
//  Smack
//
//  Created by DokeR on 18.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width * 0.85
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: toLoginSegueName, sender: nil)
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
}
