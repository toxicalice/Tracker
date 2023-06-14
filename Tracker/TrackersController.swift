//
//  TrackersController.swift
//  Tracker
//
//  Created by Алиса Долматова on 14.06.2023.
//

import Foundation

class TrackersController {
   static let shared: TrackersController = TrackersController()
    var categories: [TrackerCategory] = [TrackerCategory(header: "Пупа", trackers: []), TrackerCategory(header: "Лупа", trackers: []), TrackerCategory(header: "За", trackers: [])]
    var completedTrackers: Set<TrackerRecord> = []
}
