//
//  TrackersController.swift
//  Tracker
//
//  Created by Алиса Долматова on 14.06.2023.
//

import Foundation

class TrackersController {
   static let shared: TrackersController = TrackersController()
    var categories: [TrackerCategory] = []
    var completedTrackers: Set<TrackerRecord> = []
}
