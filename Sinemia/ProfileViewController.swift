//
//  ProfileViewController.swift
//  Sinemia
//
//  Created by EceOzturk on 23.01.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileUserName: UITextField!
    @IBOutlet weak var profileUserSurname: UITextField!
    @IBOutlet weak var profileUserEmail: UITextField!
    @IBOutlet weak var profileUserPassword: UITextField!
    let UserDb = DBUtil.sharedInstance
    //let userInf = UserInformation.sharedUser
    
    @IBOutlet var userDatePicker: UIDatePicker!
    
    var day : Int = 0
    var month : Int = 0
    var year : Int = 0
   
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateProfile()
        print("UserId : ",UserInformation.sharedUser.userId)
        print(UserInformation.sharedUser.userBirthDay)

        
        
    }
    @IBAction func valueChanged(sender : UIDatePicker ,forEvent event :UIEvent)
    {
        print("day :\(sender.date.getDayMonthYear().day)/month: \(sender.date.getDayMonthYear().month)/\(sender.date.getDayMonthYear().year)")
       // lastdate(day: sender.date.getDayMonthYear().day, month: sender.date.getDayMonthYear().month, year: sender.date.getDayMonthYear().year)
        day = sender.date.getDayMonthYear().day
        month = sender.date.getDayMonthYear().month
        year = sender.date.getDayMonthYear().year
    }

    func updateProfile(){
        
        profileUserName.text = UserInformation.sharedUser.userName
        profileUserEmail.text = UserInformation.sharedUser.userEmail
        profileUserSurname.text = UserInformation.sharedUser.userSurname
        profileUserPassword.text = UserInformation.sharedUser.userPassword
        userDatePicker.date = Date.calculateDate(year: "\(UserInformation.sharedUser.userBirthDay)")

        
    }

    @IBAction func updateButton(_ sender: UIButton) {
        
       // DBUtil.sharedInstance.updateUser(name: profileUserName.text!, surname: profileUserSurname.text!, Email: profileUserEmail.text!, password: profileUserPassword.text! )
        //"\(year)-\(month)-\(day)"
        print ("\(day),\(month),\(year)")
        if day == 0 && month == 0 && year == 0
        {
            DBUtil.sharedInstance.updateUser(name: profileUserName.text!, surname: profileUserSurname.text!, Email: profileUserEmail.text!, password: profileUserPassword.text!, birthday: "\(UserInformation.sharedUser.userBirthDay)" )
        }
        else
        {
            DBUtil.sharedInstance.updateUser(name: profileUserName.text!, surname: profileUserSurname.text!, Email: profileUserEmail.text!, password: profileUserPassword.text!, birthday: "\(year)-\(month)-\(day)" )
        }
        
   
    }
    
}
