//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Алиса Долматова on 06.06.2023.
//

import Foundation
import WebKit
import UIKit

class TrackersViewController: UIViewController {
    
    var labelName:UILabel!
    var lableData:UIDatePicker!
    var searchBar:UISearchBar!
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    override func viewDidLoad() {
        setupViews()
        setupCollectionView()
        collectionView.register(TrackerCall.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(SupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        self.view.backgroundColor = UIColor.white
    }
    
    private func setupCollectionView() {
        
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
    private func didTapButton() {
        
        
        //TODO нужно дописать логику нажатия на +
        
    //            let alert = UIAlertController(title: "Пока кай", message: "Уверены что хотите выйти?", preferredStyle: .alert)
    //            alert.addAction(UIAlertAction(title: "Нет", style: .cancel))
    //            alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { close in
    //                self.cleanStorages()
    //                self.switchToSplash()
    //            }))
    //            self.present(alert, animated: true)
    }

    
} // конец класса TrackersViewController
    
extension TrackersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TrackerCall
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
        view.titleLabel.text = "Здесь находится Supplementary view"
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



