//
//  MessagesCell.swift
//  chetChat
//
//  Created by Mohannad Tohamy on 10/20/18.
//  Copyright © 2018 Mohannad Tohamy. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class MessagesCell: UITableViewCell {
    
    @IBOutlet weak var recievedMessageLable : UILabel!
    @IBOutlet weak var recievedMessageView : UIView!
    @IBOutlet weak var sentMessageLable :  UILabel!
    @IBOutlet weak var sentMessageView : UIView!
    
    var message : Message!
    var curruntUser = KeychainWrapper.standard.string(forKey: "uid")

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(message : Message){
        self.message  = message
        
        if message.sender == curruntUser{
            sentMessageView.isHidden = false
            sentMessageLable.text = message.message
            recievedMessageLable.text = ""
            recievedMessageLable.isHidden = true
        } else {
            sentMessageView.isHidden = true
            sentMessageLable.text = ""
            recievedMessageLable.text = message.message
            recievedMessageLable.isHidden = false
        }
    }

}
