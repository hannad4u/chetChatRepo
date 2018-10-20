//
//  MessageVC.swift
//  chetChat
//
//  Created by Mohannad Tohamy on 10/18/18.
//  Copyright © 2018 Mohannad Tohamy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

class MessageVC: UIViewController ,UITableViewDelegate ,UITableViewDataSource ,UITextFieldDelegate{
    
    @IBOutlet weak var sendBtn : UIButton!
    @IBOutlet weak var messageField : UITextField!
    @IBOutlet weak var tableView : UITableView!
    
    
    var messageId:String!
    var messages = [Message]()
    var message : Message!
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    var recipient:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        if messageId != "" && messageId != nil {
            loadData()
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Message") as? MesaagesCell{
            cell.configCell(message: message)
            return cell
        }else{
            return MessagesCell()
        }
    }
    
}
