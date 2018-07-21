//
//  CreateAccountVC.swift
//  smack
//
//  Created by Adolfo Frias on 7/20/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    
    @IBOutlet weak var userImg: UIImageView!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // the VC (yellow dot) was controlled+dragged to the exit, and the segue 'action' made in the channelVC "@IBAction func prepareForUnWind" selected. Click on the unwind segue and add an identifier name
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
        guard let email = emailText.text , emailText.text != "" else {return}
        guard let pass = passTxt.text, passTxt.text != "" else {return}
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("registered user")
            }
        }
    }
    

}
