//
//  TrackerStore.swift
//  Tracker
//
//  Created by Алиса Долматова on 20.08.2023.
//

import Foundation
import CoreData
import UIKit

class TrackerStore {
    
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    convenience init() {
        self.init(context:(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        
    }
    
    func addTracker(tracker: Tracker, category: TrackerCategoryCoreData) {
       let trackerCoreData = TrackerCoreData(context: context)
        trackerCoreData.id = tracker.id
        trackerCoreData.name = tracker.name
        trackerCoreData.color = tracker.color.hexStringFromColor()
        trackerCoreData.emoji = tracker.emoji
        trackerCoreData.ordinary = tracker.ordinary.map({ dayOfWeek in
            return dayOfWeek.rawValue
        })
        trackerCoreData.category = category
       try! context.save()
    }
    
    func getTracker () -> [Tracker] {
        let request = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        let trackers = try! context.fetch(request)
        let newTrackers: [Tracker?] = trackers.map { tracker in
            guard let id = tracker.id else {return nil}
            guard let name = tracker.name else {return nil}
            guard let color = tracker.color else {return nil}
            guard let uiColor = UIColor(hex:color) else {return nil}
            guard let emoji = tracker.emoji else {return nil}
            guard let ordinary = tracker.ordinary else {return nil}

            let trackerUI = Tracker(id: id, name: name, color: uiColor, emoji: emoji, ordinary: ordinary.map({ dayOfWeek in
                guard let ordinary = Tracker.Ordinary(rawValue: dayOfWeek) else {return .friday}
                return ordinary
            }), isPinned: tracker.isPinned)
            return trackerUI
        }
        return newTrackers.compactMap({$0})
    }
    
    func updateTracker(tracker: Tracker) {
        let request = NSFetchRequest<NSManagedObjectID>(entityName: "TrackerCoreData")
        request.predicate = NSPredicate(format: " %K == %@", "id", tracker.id as CVarArg)
        request.resultType = .managedObjectIDResultType
        let managedObjectID = try! context.fetch(request).first
        guard let objectID = managedObjectID else {return}
        let object = try! context.existingObject(with: objectID) as? TrackerCoreData

//        object?.category = category
        object?.color = tracker.color.hexStringFromColor()
        object?.emoji = tracker.emoji
        object?.name = tracker.name
        object?.ordinary = tracker.ordinary.map({ dayOfWeek in
            return dayOfWeek.rawValue
        })
        try! context.save()
    }
    
    func deleteTracker (trackerID: UUID) {
        let request = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        let trackers = try! context.fetch(request)
        let tracker = trackers.first { tracker in
            tracker.id == trackerID
        }
        guard let tracker = tracker else {return}
        context.delete(tracker)
        try! context.save()
    }
    
    func pinTracker(tracker: Tracker) {
        let request = NSFetchRequest<NSManagedObjectID>(entityName: "TrackerCoreData")
        request.predicate = NSPredicate(format: " %K == %@", "id", tracker.id as CVarArg)
        request.resultType = .managedObjectIDResultType
        let managedObjectID = try! context.fetch(request).first
        guard let objectID = managedObjectID else {return}
        let object = try! context.existingObject(with: objectID) as? TrackerCoreData

        object?.isPinned = true

        try! context.save()
    }
    
    func unPinTracker(tracker: Tracker) {
        let request = NSFetchRequest<NSManagedObjectID>(entityName: "TrackerCoreData")
        request.predicate = NSPredicate(format: " %K == %@", "id", tracker.id as CVarArg)
        request.resultType = .managedObjectIDResultType
        let managedObjectID = try! context.fetch(request).first
        guard let objectID = managedObjectID else {return}
        let object = try! context.existingObject(with: objectID) as? TrackerCoreData

        object?.isPinned = false

        try! context.save()
    }
    
    
} //конец TrackerStore

