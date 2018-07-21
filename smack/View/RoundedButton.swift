//
//  RoundedButton.swift
//  smack
//
//  Created by Adolfo Frias on 7/21/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit
@IBDesignable

class RoundedButton: UIButton {
    // allows it to be in storyboard
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    // changes will show up in storyboard
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }

}
