//
//  Message.swift
//  chetChat
//
//  Created by Mohannad Tohamy on 10/20/18.
//  Copyright © 2018 Mohannad Tohamy. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

class Message {
    private var _message :String!
    private var _sender : String!
    private var _messageKey : String!
    private var _messageRef : DatabaseReference!
    
    var curruntUser = KeychainWrapper.standard.string(forKey: "uid")
    
    var message:String{
        return _message
    }
    var sender:String{
        return _sender
    }
    var messageKey:String{
        return _messageKey
    }
    
    init(message:String , sender:String){
        _message = message
        _sender = sender
    }
    init(messageKey:String , postData : Dictionary<String,AnyObject>) {
        _messageKey = messageKey
        if let message = postData["message"] as? String{
            _message = message
        }
        if let sender = postData["sender"] as? String{
            _sender  = sender
        }
        
        _messageRef = Database.database().reference().child("messages").child(_messageKey)
    }
    
}