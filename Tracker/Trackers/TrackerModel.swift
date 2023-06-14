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
    let ordinary: Set<Ordinary>
    
    enum Ordinary: String, CaseIterable {
        case monday = "Понедельник"
        case tuesday = "Вторник"
        case wednesday = "Среда"
        case thursday = "Четверг"
        case friday = "Пятница"
        case saturday = "Суббота"
        case sunday = "Воскресенье"
    }
}

struct TrackerCategory{
    let header: String
    let trackers: Array<Tracker>
}

struct TrackerRecord: Hashable {
    let idRecord: UUID
    let date: Date
}
