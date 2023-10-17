//
//  TrackerRecordStore.swift
//  Tracker
//
//  Created by Алиса Долматова on 23.08.2023.
//

import Foundation
import CoreData
import UIKit

class TrackerRecordStore {
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    convenience init() {
        self.init(context:(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        
    }
    
    func addTrackerRecord (record: TrackerRecord ) {
        let TrackerRecordCoreData = TrackerRecordCoreData(context: context)
        TrackerRecordCoreData.trackerId = record.trackerId
        TrackerRecordCoreData.date = record.date
        
        try! context.save()
    }
    
    func deleteTracerRecord (tracerID: UUID) {
        let request = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        let recods = try! context.fetch(request)
        let record = recods.first { record in
            record.trackerId == tracerID
        }
        guard let record = record else {return}
        context.delete(record)
    }
    
    func deleteAllTrackerRecord (tracerID: UUID) {
        let request = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        let recods = try! context.fetch(request)
        recods.forEach { record in
            if (record.trackerId == tracerID) {
                context.delete(record)
            }
        }
    }
    
    func getTracerRecord (tracerID: UUID) -> [TrackerRecord]{
        let request = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        let recods = try! context.fetch(request)
        let filterRecord = recods.filter { record in
            record.trackerId == tracerID
        }
        let newRecords: [TrackerRecord?] = filterRecord.map { record in
            guard let trackerId = record.trackerId else {return nil}
            guard let data = record.date else {return nil}
            let recordUI = TrackerRecord(trackerId: trackerId , date: data)
            return recordUI
        }
        return newRecords.compactMap({$0})
    }
    
} //конец класса TrackerRecordStore
