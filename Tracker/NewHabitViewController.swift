//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Алиса Долматова on 11.06.2023.
//

import Foundation
import UIKit

protocol NewHabitDelegate {
    func addTracker(tracker: Tracker, category: String)
}

class NewHabitViewController: UIViewController, AddCategoryDelegate, AddNewTimeTableDelegate {
 
    var uiHeaderLable: UILabel!
    var uiTextField: UITextField!
    var tableView: UITableView!
    let idCell = "cell"
    let callTitles = ["Категория","Расписание"]
    var trackerName:String? = nil
    let uiButtonCreate = UIButton()
    var trackersVCdelegate: NewHabitDelegate? = nil
    var selectedCategory:String?
    var selectedDay:[Tracker.Ordinary] = []
    
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        uiHeaderLable = UILabel()
        
        view.addSubview(uiHeaderLable)
        uiHeaderLable.translatesAutoresizingMaskIntoConstraints = false
        uiHeaderLable.text = "Новая привычка"
        uiHeaderLable.textColor = UIColor.black
        uiHeaderLable.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        uiHeaderLable.textAlignment = .center
        
        
        NSLayoutConstraint.activate([
            uiHeaderLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            uiHeaderLable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
        ])
        
        uiTextField = PaddedTextFeild()
        view.addSubview(uiTextField)
        uiTextField.translatesAutoresizingMaskIntoConstraints = false
        uiTextField.placeholder = "Введите название трекера"
        uiTextField.layer.cornerRadius = 16
        uiTextField.backgroundColor = UIColor(named: "ColorBackground")
        uiTextField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
        
        NSLayoutConstraint.activate([
            uiTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            uiTextField.topAnchor.constraint(equalTo: uiHeaderLable.bottomAnchor, constant: 38),
            uiTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            uiTextField.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: idCell)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "ColorBackground")
        tableView.layer.cornerRadius = 16
        
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.topAnchor.constraint(equalTo: uiTextField.bottomAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        let stack = UIStackView()
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.spacing = 8
        
        NSLayoutConstraint.activate([
            stack.heightAnchor.constraint(equalToConstant: 60),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -34)
        ])
        
        
        let uiButtonCancel = UIButton()
        uiButtonCancel.addTarget(self, action: #selector(Self.didTapButtonCancel), for: .touchUpInside)
       
        uiButtonCancel.translatesAutoresizingMaskIntoConstraints = false
        uiButtonCancel.backgroundColor = .clear
        uiButtonCancel.setTitle("Отменить", for: .normal)
        uiButtonCancel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        uiButtonCancel.setTitleColor(UIColor(named: "ColorRed"), for: .normal)
        uiButtonCancel.layer.borderColor = UIColor(named: "ColorRed")?.cgColor
        uiButtonCancel.layer.borderWidth = 1
        uiButtonCancel.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            uiButtonCancel.heightAnchor.constraint(equalToConstant: 60)
        ])
        
       
        uiButtonCreate.addTarget(self, action: #selector(Self.didTapButtonCreate), for: .touchUpInside)
        
        uiButtonCreate.translatesAutoresizingMaskIntoConstraints = false
        uiButtonCreate.backgroundColor = UIColor(named: "ColorBlack")
        uiButtonCreate.setTitle("Создать", for: .normal)
        uiButtonCreate.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        uiButtonCreate.tintColor = .white
        uiButtonCreate.layer.cornerRadius = 16
        uiButtonCreate.isEnabled = false

        NSLayoutConstraint.activate([
            uiButtonCreate.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        stack.addArrangedSubview (uiButtonCancel)
        stack.addArrangedSubview (uiButtonCreate)
        stack.axis = .horizontal
    }
    
    @objc
    private func didTapButtonHabit() {
        
        
        //TODO нужно дописать логику нажатия
   
    }
    
    @objc
    private func textChanged(_ textField: UITextField) {
        //TODO добавить логику поиска по категориям
        trackerName = textField.text
        if let trackerName = trackerName, !trackerName.isEmpty {
            uiButtonCreate.isEnabled = true
        } else {
            uiButtonCreate.isEnabled = false
        }
        
    }
    
    @objc
    private func didTapButtonCancel() {
        dismiss(animated: true)
    }
    
    @objc
    private func didTapButtonCreate() {
        // TODO доделать логику сохранения
        guard let selectedCategory = selectedCategory else {return}
        guard let trackerName = trackerName else {return}
        trackersVCdelegate?.addTracker(tracker: Tracker(id: UUID(), name: trackerName, color: .brown, emoji: "😀", ordinary: selectedDay), category: selectedCategory)
        dismiss(animated: true)
    }
    
    func categorySelected(name: String) {
        selectedCategory = name
        tableView.reloadData()
    }
    
    func addDayOfWeek(days:[Tracker.Ordinary]) {
        selectedDay = days
        tableView.reloadData()
    }
    
    
} //конец класса NewHabitViewController


extension NewHabitViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.row) {
        case 0:
            let categoriesVC = CategoriesViewController()
            categoriesVC.delegate = self
            present(categoriesVC, animated: true)
        case 1:
            let timeTableVC = TimeTableViewController()
            timeTableVC.delegate = self
            timeTableVC.setupSelectedDays(selectedDay: selectedDay)
            present(timeTableVC, animated: true)
        default:
            break
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
   
}

extension NewHabitViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: idCell)
        let title = callTitles[indexPath.row]
        cell.textLabel?.text = title
        cell.backgroundColor = .clear
        cell.accessoryType = .disclosureIndicator
        
        if indexPath.row == 0 {
            cell.detailTextLabel?.text = selectedCategory
            cell.detailTextLabel?.textColor = UIColor(named: "ColorGray")
        } else {
            if !selectedDay.isEmpty {
                var text =  ""
                selectedDay.forEach { day in
                    text += "\(day.shortText()), "
                }
                text = String(text.dropLast(2))
                cell.detailTextLabel?.text = text
                cell.detailTextLabel?.textColor = UIColor(named: "ColorGray")
            }
        }
    
       return cell
        
    }
}
