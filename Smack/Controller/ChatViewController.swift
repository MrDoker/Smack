//
//  ChatViewController.swift
//  Smack
//
//  Created by DokeR on 18.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var typingUserLabel: UILabel!
    
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        sendButton.isHidden = true
        
        ///
        ////
        //view.bindToKeyboard()
        messageTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: notifUserDataDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: notifChannelSelected, object: nil)
        
        SocketService.instance.getChatMessage { (newMessage) in
            if newMessage.channelID == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn {
                MessageService.instance.messagesArray.append(newMessage)
                self.tableView.reloadData()
                if MessageService.instance.messagesArray.count > 0 {
                    let indexPath = IndexPath(row: MessageService.instance.messagesArray.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                }
            }
        }
        
        SocketService.instance.getTypingUsers { (typingUsers) in
            guard let channelID = MessageService.instance.selectedChannel?.id else {return}
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelID {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                
                self.typingUserLabel.text = "\(names) \(verb) typing a message"
            } else {
                self.typingUserLabel.text = ""
            }
        }
        
        loginUser()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    func loginUser(){
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                //
                if success {
                    NotificationCenter.default.post(name: notifUserDataDidChange, object: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: "Something was wrong. Check you inthernet connection or try to use VPN", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (aletr) in
                        AuthService.instance.isLoggedIn = false
                        NotificationCenter.default.post(name: notifUserDataDidChange, object: nil)
                    }))
                    alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { (aletr) in
                        self.loginUser()
                    }))
                }
            }
        }
    }
    
    @objc func handleTap() {
        messageTextField.endEditing(true)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        if messageTextField.isFirstResponder {
            let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
            let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! UInt
            let curFrame = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            let targetFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let deltaY = targetFrame.origin.y - curFrame.origin.y
            
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIViewKeyframeAnimationOptions(rawValue: curve), animations: {
                self.view.frame.origin.y += deltaY
                
            },completion: {(true) in
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessges()
        } else {
            channelNameLabel.text = "Please Log In"
            tableView.reloadData()
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        channelNameLabel.text = "# \(MessageService.instance.selectedChannel?.channelTitle ?? "")"
        getMessages()
    }
    
    @IBAction func messageTextFieldEditing(_ sender: Any) {
        guard let channelID = MessageService.instance.selectedChannel?.id else { return }
        if messageTextField.text == "" {
            isTyping = false
            sendButton.isHidden = true
            SocketService.instance.socketManager.defaultSocket.emit("stopType", UserDataService.instance.name, channelID)
        } else {
            if isTyping == false {
                sendButton.isHidden = false
                SocketService.instance.socketManager.defaultSocket.emit("startType", UserDataService.instance.name, channelID)
            }
            isTyping = true
        }
    }
    
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let message = messageTextField.text else {return}
            guard let channelID = MessageService.instance.selectedChannel?.id else {return}
            
            SocketService.instance.addMessage(messageBody: message, userID: UserDataService.instance.id, channelID: channelID) { (success) in
                if success {
                    self.messageTextField.text = ""
                    self.messageTextField.resignFirstResponder()
                    SocketService.instance.socketManager.defaultSocket.emit("stopType", UserDataService.instance.name, channelID)
                }
            }
        }
    }
    
    func onLoginGetMessges() {
        MessageService.instance.findAllChannels(completion: { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLabel.text = "No channels yet"
                }
            }
        })
    }
    
    func getMessages() {
        guard let channelID = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessagesForChannel(channelID: channelID) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as? MessageTableViewCell {
            cell.configCell(with: MessageService.instance.messagesArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension ChatViewController: UITextFieldDelegate {

    
}


















