//
//  spinner.swift
//  Delimsys Phone Test
//
//  Created by imac on 6/05/19.
//  Copyright © 2019 Wiro Technologies. All rights reserved.
//

import UIKit

class spinner: UIActivityIndicatorView {
    
    override func didMoveToWindow() {
        self.isHidden = true
        self.layer.cornerRadius = 5
    }
    
}
