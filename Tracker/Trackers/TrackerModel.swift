//
//  Tracker.swift
//  Tracker
//
//  Created by Алиса Долматова on 12.06.2023.
//

import Foundation
import UIKit

struct Tracker {
    let id: UUID
    let name: String
    let color: UIColor
    let emoji: String
    let ordinary: [Ordinary]
    
    enum Ordinary: String, CaseIterable {
        case monday = "Понедельник"
        case tuesday = "Вторник"
        case wednesday = "Среда"
        case thursday = "Четверг"
        case friday = "Пятница"
        case saturday = "Суббота"
        case sunday = "Воскресенье"
        
        func shortText() -> String {
            switch self {
            case .monday : return "Пн"
            case .tuesday : return "Вт"
            case .wednesday : return "Ср"
            case .thursday : return "Чт"
            case .friday : return "Пт"
            case .saturday : return "Сб"
            case .sunday : return "Вс"
            }
        }
    }
}

struct TrackerCategory {
    let header: String
    let trackers: Array<Tracker>
}

struct TrackerRecord: Hashable {
    let trackerId: UUID
    let date: Date
}
