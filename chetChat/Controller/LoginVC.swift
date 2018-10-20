//
//  ViewController.swift
//  chetChat
//
//  Created by Mohannad Tohamy on 10/17/18.
//  Copyright © 2018 Mohannad Tohamy. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var userUid : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: "uid"){
            performSegue(withIdentifier: "toMessages", sender: nil)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSignUp"{
            
            if let destination = segue.destination as? SingUpVC{
                if self.userUid != nil{
                    destination.userID = userUid
                    
                }
                if self.emailField.text != nil{
                    destination.emaiField = emailField.text
                }
                if self.passwordField != nil{
                    destination.passwordField = passwordField.text
                }
            }
        }
    }
    @IBAction func SingIn(_ sender: Any) {
        if let email = emailField.text ,let password = passwordField.text{
            Auth.auth().signIn(withEmail :email, password :password, completion: {(user,error) in
                if error == nil{
                    self.userUid = user?.uid
                    KeychainWrapper.standard.set(self.userUid, forKey: "uid")
                    self.performSegue(withIdentifier: "toMessages", sender: nil)
                }else{
                    self.performSegue(withIdentifier: "toSignUp", sender: nil)
                }
            })
            
            
        }
    }
    
}

