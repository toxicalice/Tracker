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
    
    func getCategory(trackers: [Tracker]) -> [TrackerCategory] {
        let request = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        let categoryes = try! context.fetch(request)
        let newCategoryes = categoryes.map { category in
            let categoryUI = TrackerCategory.init(header: category.header!, trackers: trackers.filter({ tracker in
                category.trackerID?.contains(where: { id in
                    id == tracker.id
                }) ?? false
            }))
            return categoryUI
        }
        return newCategoryes
    }
    
    func getCategoryCoreData(trackers: Tracker) -> TrackerCategoryCoreData? {
        let request = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        let categoryes = try! context.fetch(request)
        return categoryes.filter { category in
            category.trackerID?.contains(where: { $0 == trackers.id}) ?? false
        }.first
    }
    
    
    func updateCategory (category: TrackerCategory) {
        let request = NSFetchRequest<NSManagedObjectID>(entityName: "TrackerCategoryCoreData")
        request.predicate = NSPredicate(format: " %K == %@", #keyPath(TrackerCategoryCoreData.header), category.header)
        request.resultType = .managedObjectIDResultType
        let managedObjectID = try! context.fetch(request).first
        guard let objectID = managedObjectID else {return}
        let object = try! context.existingObject(with: objectID) as? TrackerCategoryCoreData

        object?.trackerID = category.trackers.map({ tracer in
            tracer.id
        })
        try! context.save()
    }
    
    
} //конец TrackerCategoryStore
