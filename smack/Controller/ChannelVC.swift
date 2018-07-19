//
//  ChannelVC.swift
//  smack
//
//  Created by Adolfo Frias on 7/18/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //measure of how much rear controller is shown
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }



}
