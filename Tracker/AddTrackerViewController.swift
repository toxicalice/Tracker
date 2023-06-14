//
//  AddTrackerController.swift
//  Tracker
//
//  Created by Алиса Долматова on 11.06.2023.
//

import Foundation
import UIKit

protocol AddTrackerDelegate {
    func addTracker(tracker: Tracker, category: String)
}

class AddTrackerViewController: UIViewController, NewHabitDelegate {
    
    var uiHeaderLable: UILabel!
    var addTrackerDelegate: AddTrackerDelegate? = nil
    
    override func viewDidLoad() {
        setupViews() 
    }
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        uiHeaderLable = UILabel()
        
        view.addSubview(uiHeaderLable)
        uiHeaderLable.translatesAutoresizingMaskIntoConstraints = false
        uiHeaderLable.text = "Создание трекера"
        uiHeaderLable.textColor = UIColor.black
        uiHeaderLable.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        uiHeaderLable.textAlignment = .center
        
        
        NSLayoutConstraint.activate([
            
            uiHeaderLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            uiHeaderLable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
            
        ])
        
        
        let uiButtonHabit = UIButton()
        uiButtonHabit.addTarget(self, action: #selector(Self.didTapButtonHabit), for: .touchUpInside)
        
        view.addSubview(uiButtonHabit)
        uiButtonHabit.translatesAutoresizingMaskIntoConstraints = false
        uiButtonHabit.backgroundColor = .black
        uiButtonHabit.setTitle("Привычка", for: .normal)
        uiButtonHabit.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        uiButtonHabit.tintColor = .white
        uiButtonHabit.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            uiButtonHabit.heightAnchor.constraint(equalToConstant: 60),
            uiButtonHabit.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            uiButtonHabit.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            uiButtonHabit.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0)
        ])
        
        
        let uiButtonIrregularEvent = UIButton()
        uiButtonIrregularEvent.addTarget(self, action: #selector(Self.didTapButtonIrregularEvent), for: .touchUpInside)
        
        view.addSubview(uiButtonIrregularEvent)
        uiButtonIrregularEvent.translatesAutoresizingMaskIntoConstraints = false
        uiButtonIrregularEvent.backgroundColor = .black
        uiButtonIrregularEvent.setTitle("Нерегулярные событие", for: .normal)
        uiButtonIrregularEvent.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        uiButtonIrregularEvent.tintColor = .white
        uiButtonIrregularEvent.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            uiButtonIrregularEvent.heightAnchor.constraint(equalToConstant: 60),
            uiButtonIrregularEvent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            uiButtonIrregularEvent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            uiButtonIrregularEvent.topAnchor.constraint(equalTo: uiButtonHabit.bottomAnchor, constant: 16)
        ])
        
    
    
    }
    
    @objc
    private func didTapButtonHabit() {
        
        let addTrackerViewController = NewHabitViewController()
        addTrackerViewController.trackersVCdelegate = self
        present(addTrackerViewController, animated: true)
    }
    
    func addTracker(tracker: Tracker, category: String) {
        addTrackerDelegate?.addTracker(tracker: tracker, category: category)
        dismiss(animated: true)
    }
    
    @objc
    private func didTapButtonIrregularEvent() {
        //TODO нужно дописать логику нажатия

    }
}
