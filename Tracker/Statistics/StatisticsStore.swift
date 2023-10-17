//
//  StatisticsStore.swift
//  Tracker
//
//  Created by Алиса Долматова on 12.10.2023.
//

import Foundation
import UIKit
import CoreData

final class StatisticsStore: NSObject {
        
    let context: NSManagedObjectContext
    
    
    override init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    func getStatistics() -> Int {
        let statisticsRequest = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        do {
            let result = try context.fetch(statisticsRequest).count
            return result
        } catch {
            return 0
        }
    }
}
