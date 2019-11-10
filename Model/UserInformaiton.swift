//
//  UserInformaiton.swift
//  Sinemia
//
//  Created by EceOzturk on 23.01.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import Foundation

class UserInformation {
    
    static var sharedUser = UserInformation()
    
    var userId : Int = 0
    var userName : String = ""
    var userSurname : String = ""
    var userEmail : String = ""
    var userPassword : String = ""
    var userBirthDay : String = ""
    
}
