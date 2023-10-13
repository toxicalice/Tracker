//
//  CategoriesViewModel.swift
//  Tracker
//
//  Created by Алиса Долматова on 29.09.2023.
//

import Foundation


class CategoriesViewModel {
    
    private let trackerCategoryStore = TrackerCategoryStore()
    private let trackerStore = TrackerStore()
    var onChangeSelectedCategory: (() -> Void)?
    private (set) var selectedCategory: String? = nil {
        didSet {
            onChangeSelectedCategory?()
        }
    }
    var onChangeCellTitles: (() -> Void)?
    private (set) var cellTitles: Array<String> = [] {
        
        didSet {
            onChangeCellTitles?()
        }
    }
    
    func updateSelectedCategory (index:Int) {
        selectedCategory = cellTitles[index]
    }
    
    func getCategory () {
        cellTitles = trackerCategoryStore.getCategory(trackers: getTracker()).map { category in
            category.header
        }
    }
    
    func addCategory(name: String) {
        let newCat = TrackerCategory(header: name, trackers: [])
        trackerCategoryStore.addCategory(category: newCat)
        selectedCategory = newCat.header
        getCategory()
    }
    
   private func getTracker () -> [Tracker] {
        trackerStore.getTracker()
    }
}
