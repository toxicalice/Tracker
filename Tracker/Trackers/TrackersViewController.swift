//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Алиса Долматова on 06.06.2023.
//

import Foundation
import WebKit
import UIKit

class TrackersViewController: UIViewController, AddTrackerDelegate, TracerCellDelegate {
   
    var labelName:UILabel!
    var lableData:UIDatePicker!
    var searchBar:UISearchBar!
    var uiEmptyPlaceholder: UIImageView!
    var lableEmpty: UILabel!
    var collectionView: UICollectionView!
    // тут кончается все для верстки
    var currentDate: Date = Date()
    var visibleTrackers: [TrackerCategory] = []
    
    private func updateVisibleTrackers() {
//        let trackers = TrackersController.shared.categories.filter { category in
//            category.trackers.filter { tracker in
//                tracker.ordinary.contains { day in
//                    currentDate
//
//                }
//            }
//        }
    }
    
    override func viewDidLoad() {
        setupViews()
        setupEmptyPlaceholder()
        setupCollectionView()
        if TrackersController.shared.categories.isEmpty {
            showCollectionView(visible: false)
        } else {
            showPlaceholder(visible: false)
        }
        self.view.backgroundColor = UIColor.white
    }
    
    private func showCollectionView(visible: Bool) {
        uiEmptyPlaceholder?.isHidden = visible
        lableEmpty?.isHidden = visible
        collectionView?.isHidden = !visible
    }
    private func showPlaceholder (visible: Bool) {
        uiEmptyPlaceholder?.isHidden = !visible
        lableEmpty?.isHidden = !visible
        collectionView?.isHidden = visible
    }
    
    private func setupCollectionView() {
       
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(TrackerCall.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }
    
    private func setupEmptyPlaceholder() {
        
        let emptyPlaceholder = UIImage(named: "EmptyPlaceholder")
        
        uiEmptyPlaceholder = UIImageView()
        
        view.addSubview(uiEmptyPlaceholder)
        uiEmptyPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        uiEmptyPlaceholder.image = emptyPlaceholder
        
        NSLayoutConstraint.activate([
            uiEmptyPlaceholder.widthAnchor.constraint(equalToConstant: 80),
            uiEmptyPlaceholder.heightAnchor.constraint(equalToConstant: 80),
            uiEmptyPlaceholder.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0),
            uiEmptyPlaceholder.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
        ])
        
        
        lableEmpty = UILabel()
        
        view.addSubview(lableEmpty)
        lableEmpty.translatesAutoresizingMaskIntoConstraints = false
        lableEmpty.text = "Что будем отслеживать?"
        lableEmpty.textColor = UIColor.black
        lableEmpty.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        lableEmpty.textAlignment = .center
 
        
        NSLayoutConstraint.activate([
            
            lableEmpty.topAnchor.constraint(equalTo: uiEmptyPlaceholder.bottomAnchor, constant: 8),
            lableEmpty.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            lableEmpty.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
            
        ])
        
        
    }
    
    private func setupViews() {
        
        
        let uiButton = UIButton.systemButton(with: UIImage(named:"plusButton")!, target: self, action: #selector(Self.didTapButton))
        
        view.addSubview(uiButton)
        uiButton.translatesAutoresizingMaskIntoConstraints = false
        uiButton.tintColor = .black
        
        NSLayoutConstraint.activate([
            uiButton.widthAnchor.constraint(equalToConstant: 42),
            uiButton.heightAnchor.constraint(equalToConstant: 42),
            uiButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            uiButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6)
            
        ])
        
        
    
        lableData = UIDatePicker()
        
        view.addSubview(lableData)
        lableData.translatesAutoresizingMaskIntoConstraints = false
        lableData.date = Date()
        lableData.datePickerMode = .date
        lableData.preferredDatePickerStyle = .compact
        lableData.addTarget(self, action: #selector(onDayPicked(date:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            
            lableData.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 47),
            lableData.widthAnchor.constraint(equalToConstant: 77),
            lableData.heightAnchor.constraint(equalToConstant: 34),
            lableData.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        
        labelName = UILabel()
        
        view.addSubview(labelName)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.text = "Трекеры"
        labelName.textColor = UIColor.black
        labelName.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: uiButton.bottomAnchor, constant: 1),
            labelName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            labelName.trailingAnchor.constraint(equalTo: lableData.trailingAnchor, constant: 12)
        ])
        
        
        
        searchBar = UISearchBar()
        
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Поиск"
        searchBar.searchBarStyle = .minimal

     
        NSLayoutConstraint.activate([

            searchBar.heightAnchor.constraint(equalToConstant: 36),
            searchBar.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 7),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
            
        ])
    }
    
    @objc
    private func onDayPicked(date: UIDatePicker) {
        currentDate = date.date
        presentedViewController?.dismiss(animated: false, completion: nil)
        
    }
    
    @objc
    private func didTapButton() {
        
       let addTrackerViewController = AddTrackerViewController()
        addTrackerViewController.addTrackerDelegate = self
       present(addTrackerViewController, animated: true)
   
    }
    
    func addTracker(tracker: Tracker, category: String) {
        
        dismiss(animated: true)
        let oldCat = TrackersController.shared.categories.first { cat in
            cat.header == category
        }
        
       if let oldCat = oldCat
        {
           var newTrackers = oldCat.trackers
           newTrackers.append(tracker)
           
           let newCat = TrackerCategory(header: oldCat.header, trackers: newTrackers)
           let index = TrackersController.shared.categories.firstIndex { cat in
               cat.header == category
           }
           guard let index = index else {return}
           TrackersController.shared.categories.remove(at: index)
           TrackersController.shared.categories.insert(newCat, at: index)
       } else {
            TrackersController.shared.categories.append(TrackerCategory(header: category, trackers: [tracker]))
            
        }
       showCollectionView(visible: true)
        collectionView.reloadData()
    }
    
    func addDayForCounter(tracker: Tracker) {
        
        let tracerRecord = TrackerRecord(trackerId: tracker.id, date: currentDate)
        TrackersController.shared.completedTrackers.insert(tracerRecord)
    }
    
    func removeDayForCounter(tracker: Tracker) {
        let tracerRecord = TrackerRecord(trackerId: tracker.id, date: currentDate)
        TrackersController.shared.completedTrackers.remove(tracerRecord)
    }
    
    
} // конец класса TrackersViewController
    
extension TrackersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TrackersController.shared.categories[section].trackers.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TrackersController.shared.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TrackerCall
        let category = TrackersController.shared.categories[indexPath.section]
        let done = TrackersController.shared.isTrackerDone(date: currentDate, trackerID: category.trackers[indexPath.row].id)
        cell?.setupCell(tracker: category.trackers[indexPath.row], daysCount: 5, done: done)
        cell?.delegate = self
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var id: String
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = "header"
        case UICollectionView.elementKindSectionFooter:
            id = "footer"
        default:
            id = ""
        }
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as! SupplementaryView
        view.titleLabel.text = TrackersController.shared.categories[indexPath.section].header
        return view
    }
    }

    
extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthView = (collectionView.bounds.width ) / 2 - 5
        return CGSize(width:widthView, height: 0.886 * widthView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            
            let indexPath = IndexPath(row: 0, section: section)
            let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
            
            return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                             height: UIView.layoutFittingExpandedSize.height),
                                                             withHorizontalFittingPriority: .required,
                                                             verticalFittingPriority: .fittingSizeLevel)           
        }
}



