//
//  SingUpVC.swift
//  chetChat
//
//  Created by Mohannad Tohamy on 10/17/18.
//  Copyright © 2018 Mohannad Tohamy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class SingUpVC: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var userImagePicker: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    
    var userID : String!
    var emaiField : String!
    var passwordField : String!
    var imagePicar : UIImagePickerController!
    var imageSelected = false
    var username: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicar = UIImagePickerController()

        imagePicar.delegate = self
        imagePicar.allowsEditing = true
        

    }
    override func viewDidDisappear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: "uid"){
            performSegue(withIdentifier: "toMessages", sender: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            userImagePicker.image = image
            imageSelected = true
            
        }else{
            print("image was't selected")
        }
        
        imagePicar.dismiss(animated: true, completion: nil)
        
    }
    
    func setUser(imag : String){
        let userData = ["username":username! ,
                        "userImage" : imag]
        KeychainWrapper.standard.set(userID, forKey: "uid")
        let location = Database.database().reference().child("useres").child(userID)
        location.setValue(userData)
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImg(){
        if usernameField.text == nil{
            signUpBtn.isEnabled = false
        }else {
            username = usernameField.text
            signUpBtn.isEnabled = true
        }
        guard let imag = userImagePicker.image ,imageSelected == true else {
            print("Image need to be selected")
            return
        }
        
        if let imgData = imag.jpegData(compressionQuality:0.2){
            let imgUid = NSUUID().uuidString
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            Storage.storage().reference().child(imgUid).putData(imgData, metadata: metaData){
                (metaData , error) in
                if error != nil {
                    print("didnt upload image")
                }else {
                    print("uploded")
                    let downloadURL = metaData?.downloadURL()?.absoluteString
                    if let url = downloadURL{
                        self.setUser(imag : url)
                    }
                    
                }
            }
            
            
        }
        
        
        
    }
    
    @IBAction func createAccunt(_ sender: Any) {
        Auth.auth().createUser(withEmail: emaiField, password: passwordField, completion: {(user,error) in
            if error != nil{
            print("Can't create user")
            }else {
                if let user = user{
                    self.userID = user.uid
                }
            }
            self.uploadImg()
        })
    }
    
    @IBAction func selectedImage(_ sender: Any) {
        present(imagePicar, animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
