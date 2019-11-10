//
//  DatePicker.swift
//  Sinemia
//
//  Created by EceOzturk on 26.01.2019.
//  Copyright © 2019 EceOzturk. All rights reserved.
//

import Foundation
import UIKit

extension Date{
    
    static func calculateDate (day :Int,month: Int,year :Int)->Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSİX")
        let calculateDate = formatter.date(from: "\(year)-\(month)-\(day)")
        return calculateDate!
    }
    static func calculateDate (year : String)->Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSİX")
        let calculateDate = formatter.date(from: "\(year)")
        return calculateDate!
    }
    func getDayMonthYear() -> (day : Int, month : Int,year:Int){
        let calender = Calendar.current
        let day = calender.component(.day, from: self)
        let month = calender.component(.month, from: self)
        let year = calender.component(.year, from: self)
        return(day,month,year)
    }
}
