//
//  TrackersController.swift
//  Tracker
//
//  Created by Алиса Долматова on 14.06.2023.
//

import Foundation

class TrackersController {
   static let shared: TrackersController = TrackersController()
    var categories: [TrackerCategory] = [
        TrackerCategory(header: "cat1", trackers: [
            Tracker(id: UUID(), name: "Cat", color: .blue, emoji: "📛", ordinary: [.friday, .monday]),
            Tracker(id: UUID(), name: "dog", color: .red, emoji: "📛", ordinary: [.thursday, .saturday]),
            Tracker(id: UUID(), name: "track", color: .blue, emoji: "📛", ordinary: [.monday]),
        ]),
        
        TrackerCategory(header: "cat2", trackers: [
            Tracker(id: UUID(), name: "track87", color: .green, emoji: "📛", ordinary: [.tuesday])
        ])
    ]
    
    var completedTrackers: Set<TrackerRecord> = []
    
    func isTrackerDone(date:Date, trackerID:UUID) -> Bool {
         completedTrackers.first { record in
            record.trackerId == trackerID && record.date == date
        } != nil
    }
    
    func completedTrackersCount(id: UUID) -> Int {
        let filterID = completedTrackers.filter { tracerRecord in
            tracerRecord.trackerId == id
        }
     return filterID.count
    }
}
