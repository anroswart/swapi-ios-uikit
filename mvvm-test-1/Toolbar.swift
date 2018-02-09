//
//  Toolbar.swift
//  mvvm-test-1
//
//  Created by Anro Swart on 2018/02/07.
//  Copyright © 2018 NRTJ. All rights reserved.
//

import UIKit

class Toolbar: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.shadowRadius = 4
    }
}
