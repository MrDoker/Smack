//
//  CircleImageView.swift
//  Smack
//
//  Created by DokeR on 21.08.2018.
//  Copyright © 2018 DokeR. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
