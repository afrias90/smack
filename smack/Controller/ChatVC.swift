//
//  ChatVC.swift
//  smack
//
//  Created by Adolfo Frias on 7/18/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    //outlets
    
    @IBOutlet weak var menuBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
    }


}
