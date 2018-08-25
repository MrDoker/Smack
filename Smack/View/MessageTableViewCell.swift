//
//  MessageTableViewCell.swift
//  Smack
//
//  Created by DokeR on 24.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: CircleImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(with message: Message) {
        messageBodyLabel.text = message.message
        userNameLabel.text = message.userName
        userImageView.image = UIImage(named: message.userAvatar)
        userImageView.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }

}
