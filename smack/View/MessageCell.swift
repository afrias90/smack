//
//  MessageCell.swift
//  smack
//
//  Created by Adolfo Frias on 8/6/18.
//  Copyright © 2018 Adolfo Frias. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    // outlets
    
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configureCell(message: Message) {
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }

   

}
