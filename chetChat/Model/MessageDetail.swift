//
//  MessageDetail.swift
//  chetChat
//
//  Created by Mohannad Tohamy on 10/18/18.
//  Copyright © 2018 Mohannad Tohamy. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

class MessageDetail{
    private var _recipient: String!
    private var _messageKey: String!
    private var _messageRef: DatabaseReference!
    var curruntUser = KeychainWrapper.standard.string(forKey: "uid")
    
    var recepent:String{
        return _recipient
    }
    var messageKey:String{
        return _messageKey
    }
    var messageRef:DatabaseReference{
        return _messageRef
    }
    
    init(recepent:String) {
        _recipient = recepent
    }
    init(messageKey:String , messageData:Dictionary<String ,AnyObject>) {
        _messageKey = messageKey
       if let recipient = messageData["recepient"] as? String{
            _recipient = recepent
        }
        _messageRef = Database.database().reference().child("recepient").child(_messageKey)
    }
    
    
    
}
