//
//  ViewController.swift
//  Sinemia
//
//  Created by EceOzturk on 14.01.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import UIKit
import SQLite3


class LoginController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    

    let UserDb = DBUtil.sharedInstance
    static var login = LoginController()
    //var userId = UserInformation.sharedUser.userId
   
    
    
    let userInf = UserInformation.sharedUser
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        DBUtil.sharedInstance.getById()
        //DBUtil.sharedInstance.selectUser()
        //passwordText.secureTextEntry = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    @IBAction func loginBTN(_ sender: UIButton) {
        print("çalıştı")
        do {
            let users = try DBUtil.sharedInstance.db!.prepare(UserDb.User)
            for user in users{
                if user[UserDb.userName] == nameText.text! && user[UserDb.userPasword] == passwordText.text!
                {
                    for user in try DBUtil.sharedInstance.db!.prepare(UserDb.User.select(UserDb.userId,UserDb.userName,UserDb.userSurname,
                                                                                         UserDb.userEmail, UserDb.userPasword,UserDb.userBirthDay)) {
                       print("id: \(user[UserDb.userId]), email: \(user[UserDb.userName])")
                        if user[UserDb.userName] == nameText.text!
                        {
                        print("id : \(user[UserDb.userId])")
                        userInf.userId = user[UserDb.userId]
                        userInf.userSurname = user[UserDb.userSurname]
                        userInf.userPassword = user[UserDb.userPasword]
                        userInf.userEmail = user[UserDb.userEmail]
                        userInf.userBirthDay = user[UserDb.userBirthDay]
                            
                    }
                    }
                    userInf.userName = nameText.text!
                    print("tebrikler!")
                    self.performSegue(withIdentifier: "goToView", sender: self)
                }
                else{
                    print("Hatalı")
                }
            }
            
        }
        catch  {
            print(error)
        }
    }
}

