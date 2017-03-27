//
//  LoginViewController.swift
//  immedia social
//
//  Created by George Kapoya on 2017/03/23.
//  Copyright © 2017 immedia. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper


class LoginViewController: UIViewController {

    @IBOutlet weak var edtPassword: UITextField!
    @IBOutlet weak var edtuserName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
      

    }

    
    override  func viewWillAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "HomeTableViewController")
             self.present(viewController, animated: true, completion: nil)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    @IBAction func btnLoginTapped(_ sender: Any) {
        print("tapped")
        if let email = edtuserName.text, let passwd = edtPassword.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: passwd, completion: {(user,error) in
                if error == nil{
                    if let userid = user?.uid  {
                        self.completSignIn(id:  userid)
                    }
                }else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: passwd, completion: {(user,error) in
                        if error == nil{
                            if let userid = user?.uid   {
                                self.completSignIn(id: userid)
                            }
                        }else{
                            print("error registering user")
                        }
                    })
                        
                }
            })
            
        }else{
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    func completSignIn(id: String) {
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("user keyChain saved")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeTableViewController")
        self.present(viewController, animated: true, completion: nil)
    }
}
