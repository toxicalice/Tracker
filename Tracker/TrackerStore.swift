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
            }))
            return trackerUI
        }
        return newTrackers.compactMap({$0})
    }
    
} //конец TrackerStore

