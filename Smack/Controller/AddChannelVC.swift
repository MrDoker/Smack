//
//  AddChannelVC.swift
//  Smack
//
//  Created by DokeR on 22.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit

class AddChannelVC: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var modalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func closeModelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createChannelTapped(_ sender: Any) {
        guard let channelName = nameTextField.text, nameTextField.text != "" else { return }
        guard let channelDescription = descriptionTextField.text, descriptionTextField.text != "" else { return }
        
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDescription) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setupView() {
        modalView.layer.cornerRadius = 6
        modalView.clipsToBounds = true
        
        nameTextField.delegate = self
        descriptionTextField.delegate = self
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor: purplePlaceholderColor])
        descriptionTextField.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor: purplePlaceholderColor])
        
        let modalViewTap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        modalView.addGestureRecognizer(modalViewTap)
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(closeTap))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func closeTap() {
        dismiss(animated: true, completion: nil)
    }
}

extension AddChannelVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
