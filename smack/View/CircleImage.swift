//
//  CircleImage.swift
//  smack
//
//  Created by Adolfo Frias on 7/24/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        //gives a perfect circle
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        
    }

}
