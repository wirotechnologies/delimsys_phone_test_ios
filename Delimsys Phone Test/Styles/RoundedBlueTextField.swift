//
//  RoundedBlueTextField.swift
//  Delimsys Phone Test
//
//  Created by imac on 3/05/19.
//  Copyright © 2019 Wiro Technologies. All rights reserved.
//

import UIKit

class RoundedBlueTextField: UITextField {

    override func didMoveToWindow() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor(red:0.68, green:0.90, blue:1.00, alpha:1.0).cgColor
    }


}
