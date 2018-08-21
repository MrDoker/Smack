//
//  AvatarCollectionViewCell.swift
//  Smack
//
//  Created by DokeR on 21.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}

class AvatarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configCell(index: Int, type: AvatarType) {
        if type == AvatarType.dark {
            avatarImage.image = UIImage(named: "dark\(index)")
            layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        } else {
            avatarImage.image = UIImage(named: "light\(index)")
            layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func setupView() {
        layer.cornerRadius = 10
        layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        clipsToBounds = true
    }
    
}

