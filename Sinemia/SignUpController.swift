//
//  SecondViewController.swift
//  Sinemia
//
//  Created by EceOzturk on 19.01.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import UIKit
import SQLite

class SignUpController: UIViewController {


    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var paswordTextField: UITextField!
    
    let UserDb = DBUtil.sharedInstance
    let userInf = UserInformation.sharedUser
    var birtDay : Int = 0
    var birtMonth : Int = 0
    var birtYear : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        DBUtil.sharedInstance.getById()

        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.datePickerMode = .date
        datePicker.tintColor = UIColor.white
         
    }
    
    @IBAction func valueChanged(sender : UIDatePicker ,forEvent event :UIEvent)
    {
        print("day :\(sender.date.getDayMonthYear().day)/month: \(sender.date.getDayMonthYear().month)/\(sender.date.getDayMonthYear().year)")
        lastdate(day: sender.date.getDayMonthYear().day, month: sender.date.getDayMonthYear().month, year: sender.date.getDayMonthYear().year)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
    }
  
    func lastdate( day : Int, month:Int, year :Int)
    {
        print("\(day).\(month).\(year)")
        birtDay = day
        birtYear = year
        birtMonth = month
        
    }

  
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        
     
        DBUtil.sharedInstance.addUser(name: nameTextField.text!, surname: surnameTextField.text!, email: emailTextField.text!, password: paswordTextField.text!, userdate : "\(birtYear)-\(birtMonth)-\(birtDay)" )
        //DBUtil.sharedInstance.addPaket()
        
       // DBUtil.sharedInstance.addUserPaket()
        UserPaket()
       
    }
    func UserPaket()
    {
        do {
            let users = try DBUtil.sharedInstance.db!.prepare(UserDb.User)

            for user in users{
                if user[UserDb.userName] == nameTextField.text!
                {
                    for user in try DBUtil.sharedInstance.db!.prepare(UserDb.User.select(UserDb.userId,UserDb.userName,UserDb.userSurname,
                                                                                         UserDb.userEmail, UserDb.userPasword,UserDb.userBirthDay)) {
                                                                                            print("id: \(user[UserDb.userId]), email: \(user[UserDb.userName])")
                                                                                            if user[UserDb.userName] == nameTextField.text!
                                                                                            {
                                                                                                print("id : \(user[UserDb.userId])")
                                                                                                userInf.userId = user[UserDb.userId]
                                                                                                userInf.userSurname = user[UserDb.userSurname]
                                                                                                userInf.userPassword = user[UserDb.userPasword]
                                                                                                userInf.userEmail = user[UserDb.userEmail]
                                                                                                userInf.userBirthDay = user[UserDb.userBirthDay]
                                                                                                
                                                                                            }
                                                                                            
                    }
                    
                    userInf.userName = nameTextField.text!
                    DBUtil.sharedInstance.addPaket(id: userInf.userId)
                    
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
