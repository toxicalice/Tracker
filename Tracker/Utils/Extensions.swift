//
//  Extensions.swift
//  Tracker
//
//  Created by Алиса Долматова on 28.06.2023.
//

import Foundation

extension Date {
    // returns an integer from 1 - 7, with 1 being Sunday and 7 being Saturday
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

extension Int {
     func days() -> String {
     var day = self % 100 / 10
         
         if day == 1 {return "дней"}
         
         switch self % 10 {
         case 1:
             return "день"
         case 2:
             return "дня"
         case 3:
             return "дня"
         case 4:
             return "дня"
         default:
            return "дней"
         }
    }
}
