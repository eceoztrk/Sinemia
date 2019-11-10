//
//  DBUtil.swift
//  Sinemia
//
//  Created by EceOzturk on 20.01.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import Foundation
import SQLite

class DBUtil {
    static var sharedInstance = DBUtil()
    var db : Connection?
    let User = Table("User")
    let userId = Expression<Int>("UserId")
    let userName = Expression<String>("UserName")
    let userSurname = Expression<String>("UserSurname")
    let userEmail = Expression<String>("UserEmail")
    let userPasword = Expression<String>("UserPassword")
    let userBirthDay = Expression<String>("UserBirthDay")
    let paket = Table("Paket")
    let paketId = Expression<Int>("paketId")
    let UserId = Expression<Int>("userId")
    let paketName = Expression<String>("paketName")
    let paketHak = Expression<Int>("paketHak")
    init() {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print(path)
        do {
            try db = Connection("\(path)/ Sinema.sqlite3")
            print("Başarılı")
            try db!.run(User.create(temporary: false, ifNotExists: true, block: {
                t in
                t.column(userId, primaryKey : true)
                t.column(userName)
                t.column(userSurname)
                t.column(userEmail)
                t.column(userPasword)
                t.column(userBirthDay)
            }))
            try db!.run(paket.create(temporary: false, ifNotExists: true, block: {
                t in
                t.column(paketId, primaryKey : true)
                t.column(UserId)
                t.column(paketName)
                t.column(paketHak)
                t.foreignKey(UserId, references: User, userId)
                

            }))

        }
        catch  {
            print(error)
        }
        
    }
    func addUser(name : String,surname : String,email : String ,password : String,userdate :String)
    {
        do {
            try db!.run(User.insert(userName <- name, userSurname <- surname, userEmail <- email , userPasword <- password,userBirthDay <- userdate))
            
        } catch  {
            print(error)
        }
    }
    func addPaket(id :Int)
    {
        do {
            try db!.run(paket.insert(paketName <- "Aylık Paket", paketHak <- 3 , UserId <- id))
            
        } catch  {
            print(error)
        }
    }

    func selectUser( name : String, password :String)
    {
      
        do {
           let users = try  self.db!.prepare(User)
            for user in users{
                print("userId: \(user[self.userId]),name: \(user[self.userName]),surname: \(user[self.userSurname])email: \(user[self.userEmail]),password: \(user[self.userPasword])")
                let name = user[self.userName]
                let password = user[self.userPasword]
                
            }
         
            
        } catch  {
            print(error)
        }
    }
    func updateUser(name : String,surname :String, Email:String,password:String, birthday : String){
        
        do {
             let userFilter  = User.filter(userId == UserInformation.sharedUser.userId)
            try db!.run(userFilter.update(userName <- name,userSurname <- surname,
                                     userEmail <- Email,userPasword <- password, userBirthDay <- birthday
            ))
            
        } catch  {
            print(error)
        }
       
    }
    func getById()
    {
        
    }
    
    
    
}


