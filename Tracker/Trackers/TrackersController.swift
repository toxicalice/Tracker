//
//  TrackersController.swift
//  Tracker
//
//  Created by Алиса Долматова on 14.06.2023.
//

import Foundation

class TrackersController {
   static let shared: TrackersController = TrackersController()
    
    private let trackerStore = TrackerStore()
    private let trackerCategoryStore = TrackerCategoryStore()
    private let trackerRecordStore = TrackerRecordStore()
    
    func isTrackerDone(date:Date, trackerID:UUID) -> Bool {
        trackerRecordStore.getTracerRecord(tracerID: trackerID).first { record in
            record.trackerId == trackerID && record.date == date
        } != nil
    }
    
    func completedTrackersCount(id: UUID) -> Int {
        let filterID = trackerRecordStore.getTracerRecord(tracerID: id).filter { tracerRecord in
            tracerRecord.trackerId == id
        }
     return filterID.count
    }
    
    
    func addTracker(tracker: Tracker, category: TrackerCategory) {
        let category = trackerCategoryStore.getCategoryCoreData(trackers: tracker)
        guard let category = category else {return}
        trackerStore.addTracker(tracker: tracker, category: category)
    }
    
    func getTracker () -> [Tracker] {
        trackerStore.getTracker()
    }
    
    func deleteTracker (trackerID: UUID) {
        trackerStore.deleteTracker(trackerID: trackerID)
    }
    
    func addCategory(category: TrackerCategory) {
        trackerCategoryStore.addCategory(category: category)
    }
    
    func getCategory () -> [TrackerCategory] {
        trackerCategoryStore.getCategory(trackers: getTracker())
    }
    
    func updateCategory (category: TrackerCategory) {
        trackerCategoryStore.updateCategory(category: category)
    }
    
    func addTrackerRecord (record: TrackerRecord ) {
        trackerRecordStore.addTrackerRecord(record: record)
    }
    
    func updateTracker (tracker: Tracker) {
        trackerStore.updateTracker(tracker: tracker)
    }
    
    func deleteTracerRecord (tracerID: UUID) {
        trackerRecordStore.deleteTracerRecord(tracerID: tracerID)
    }
    
} //конец класса TrackersController
