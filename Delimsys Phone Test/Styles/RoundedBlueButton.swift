//
//  RoundedBlueButton.swift
//  Delimsys Phone Test
//
//  Created by imac on 3/05/19.
//  Copyright © 2019 Wiro Technologies. All rights reserved.
//

import UIKit

class RoundedBlueButton: UIButton {

    override func didMoveToWindow() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor(red:0.00, green:0.38, blue:0.67, alpha:1.0).cgColor
    }

}
