//
//  messageDetailCell.swift
//  chetChat
//
//  Created by Mohannad Tohamy on 10/18/18.
//  Copyright © 2018 Mohannad Tohamy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import SwiftKeychainWrapper

class messageDetailCell: UITableViewCell {
    @IBOutlet weak var recipientImg : UIImageView!
    @IBOutlet weak var recipientName : UILabel!
    @IBOutlet weak var chatPreview : UILabel!
    var messageDetail : MessageDetail!
    var userPostKey :DatabaseReference!
    let curruntUser = KeychainWrapper.standard.string(forKey: "uid")
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configurCell(messageDetail:MessageDetail) {
        self.messageDetail = messageDetail
        let recipeintData = Database.database().reference().child("users").child(messageDetail.recepent)
        
        recipeintData.observeSingleEvent(of: .value, with: {(snapshot) in
            let data = snapshot.value as! Dictionary<String, AnyObject>
            let username = data["username"]
            let userImg = data["userImg"]
            self.recipientName.text = username as? String
            let ref = Storage.storage().reference(forURL: userImg as! String)
            ref.getData(maxSize: 100000, completion: {(data ,error) in
                if error != nil{
                    print("could not loded")
                }else{
                    if let imageData = data {
                        if let image = UIImage(data: imageData){
                            self.recipientImg.image = image
                        }
                    }
                }
                
            })
            
            
            
            
            
        })
    }

}
