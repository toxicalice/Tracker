//
//  TrackerCategoryStore.swift
//  Tracker
//
//  Created by Алиса Долматова on 23.08.2023.
//

import Foundation
import CoreData
import UIKit

class TrackerCategoryStore {
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    convenience init() {
        self.init(context:(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        
    }
    
    func addCategory(category: TrackerCategory) {
        let TrackerCategoryCoreData = TrackerCategoryCoreData(context: context)
        TrackerCategoryCoreData.header = category.header
        TrackerCategoryCoreData.trackerID = category.trackers.map({ tracker in
            tracker.id
        })
        try! context.save()
    }
    
    func getTracker () -> [TrackerCategory] {
        let request = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        let categoryes = try! context.fetch(request)
     
    }
    
    
} //конец TrackerCategoryStore
