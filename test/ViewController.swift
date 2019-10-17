//
//  ViewController.swift
//  test
//
//  Created by manager on 2019/09/26.
//  Copyright © 2019年 manager. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var mailfield: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func myButton() {
        let email = mailfield.text ?? ""
        let pass = passField.text ?? ""
        let name = nameField.text ?? ""
        
        Auth.auth().createUser(withEmail: email, password: pass){[weak self]result,error in guard let self = self else{return}
            if let user = result?.user{
                let req = user.createProfileChangeRequest()
                req.displayName = name
                req.commitChanges(){[weak self]error in guard let self = self else{return}
                    if error == nil{
                        user.sendEmailVerification(){ [weak self] error in guard let self = self else{ return }
                            if error == nil{
                                
                            }
                            self.showErrorIfNeeded(error)
                        }
                    }
                    self.showErrorIfNeeded(error)
                }
            }
            self.showErrorIfNeeded(error)
        }
    }
    
    private func showErrorIfNeeded(_ errorOrNil:Error?){
        guard let error = errorOrNil else{return}
        
        let message = "エラーが起きました"
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert,animated: true,completion: nil)
    }
}

