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



