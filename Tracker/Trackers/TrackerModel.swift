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
    let isPinned: Bool
    
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
            case .monday : return NSLocalizedString("tracker.Model.ordinary.monday", comment: "")
            case .tuesday : return NSLocalizedString("tracker.Model.ordinary.tuesday", comment: "")
            case .wednesday : return NSLocalizedString("tracker.Model.ordinary.wednesday", comment: "")
            case .thursday : return NSLocalizedString("tracker.Model.ordinary.thursday", comment: "")
            case .friday : return NSLocalizedString("tracker.Model.ordinary.friday", comment: "")
            case .saturday : return NSLocalizedString("tracker.Model.ordinary.saturday", comment: "")
            case .sunday : return NSLocalizedString("tracker.Model.ordinary.sunday", comment: "")
            }
        }
        
        static func getByIndex (index: Int?) -> Ordinary {
            switch index {
            case 1:
                return .sunday
            case 2:
                return .monday
            case 3:
                return .tuesday
            case 4:
                return .wednesday
            case 5:
                return .thursday
            case 6:
                return .friday
            case 7:
                return .saturday
            default:
                return .sunday //потом поправлю, в тз небыло))
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
