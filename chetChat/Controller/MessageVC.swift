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
        func keyboardWillShow(notify : NSNotification){
            
            if let keyboardSize = (notify.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
        
        func keyboardWillHide(notify : NSNotification){
            
            if let keyboardSize = (notify.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y != 0{
                    self.view.frame.origin.y += keyboardSize.height
                }
            }
        }
        
        func dismissKeyboard(){
            view.endEditing(true)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        DispatchQueue.main.asyncAfter(deadline: .now() + milliseconds(300)){
            self.movToBottom()
            
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Message") as? MessagesCell{
            cell.configCell(message: message)
            return cell
            
            
        }else{
            return MessagesCell()
        }
    }
    
    func loadData(){
        Database.database().reference().child("messages").child(messageId).observe(.value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                self.messages.removeAll()
                
                for data in snapshot{
                    if let postDict = data.value as? Dictionary<String,AnyObject>{
                        let key = data.key
                        let post = Message(messageKey: key, postData: postDict)
                        self.messages.append(post)
                    }
                }
            }
            self.tableView.reloadData()
            
            
        })
    }
    
    func movToBottom(){
        
        if messages.count > 0{
            let indexPath = IndexPath(row: messages.count-1, section: 0)
            
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }

    @IBAction func sendPressed(_ sender: AnyObject){
        
        
    }
    
}
