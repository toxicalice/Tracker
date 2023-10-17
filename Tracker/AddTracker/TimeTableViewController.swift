//
//  imeTableViewController.swift
//  Tracker
//
//  Created by Алиса Долматова on 12.06.2023.
//

import Foundation
import UIKit

protocol AddNewTimeTableDelegate {
    func addDayOfWeek (days:[Tracker.Ordinary])
}

class TimeTableViewController: UIViewController {
    var uiHeaderLable: UILabel!
    var uiEmptyPlaceholder: UIImageView!
    var lableEmpty: UILabel!
    var tableView: UITableView!
    let idCell = "cell"
    let cellTitles = Tracker.Ordinary.allCases
    var selectedTitles: Dictionary<Tracker.Ordinary, Bool> = [
        .monday : false,
        .tuesday : false,
        .wednesday : false,
        .thursday : false,
        .friday : false,
        .saturday : false,
        .sunday : false
    ]
    var delegate: AddNewTimeTableDelegate?
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        uiHeaderLable = UILabel()
        
        view.addSubview(uiHeaderLable)
        uiHeaderLable.translatesAutoresizingMaskIntoConstraints = false
        uiHeaderLable.text = NSLocalizedString("timeTable.uiHeaderLable", comment: "")
        uiHeaderLable.textColor = UIColor.black
        uiHeaderLable.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        uiHeaderLable.textAlignment = .center
        
        
        NSLayoutConstraint.activate([
            uiHeaderLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            uiHeaderLable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
        ])
        
        
        let uiButtonReady = UIButton()
        uiButtonReady.addTarget(self, action: #selector(self.didTapButtonuReady), for: .touchUpInside)
        
        view.addSubview(uiButtonReady)
        uiButtonReady.translatesAutoresizingMaskIntoConstraints = false
        uiButtonReady.backgroundColor = .black
        uiButtonReady.setTitle(NSLocalizedString("timeTable.uiButtonReady", comment: ""), for: .normal)
        uiButtonReady.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        uiButtonReady.tintColor = .white
        uiButtonReady.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            uiButtonReady.heightAnchor.constraint(equalToConstant: 60),
            uiButtonReady.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            uiButtonReady.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            uiButtonReady.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: idCell)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.topAnchor.constraint(equalTo: uiHeaderLable.bottomAnchor, constant: 38),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(greaterThanOrEqualTo: uiButtonReady.topAnchor, constant: -16) // нужно подстроить под количество ячеек
        ])
        
    }
    
    func setupSelectedDays(selectedDay: [Tracker.Ordinary]) {
        selectedDay.forEach { day in
            selectedTitles[day] = true
        }
        tableView?.reloadData()
    }
    
    
    @objc
    private func didTapButtonuReady() {
        let days = selectedTitles.filter { _, value in
            value == true
        }
        delegate?.addDayOfWeek(days: days.keys.map({ $0 })) //TODO добавить сортировку элементов в следующей жизни
        dismiss(animated: true)
    }
    
}//конец класса TimeTableViewController


extension TimeTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    
}

extension TimeTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellTitles.count
    }
    
    @objc
    func onSwitchChanged(_ switchView: UISwitch) {
       let dayOfWeek = cellTitles[switchView.tag]
        selectedTitles[dayOfWeek] = switchView.isOn
    }
    
    func createSwitch(index: IndexPath) -> UISwitch {
        let switchView = UISwitch()
        switchView.onTintColor = UIColor(named: "Blue")
        switchView.addTarget(self, action: #selector(onSwitchChanged(_:)), for: .valueChanged)
        switchView.tag = index.row
        let key = cellTitles[index.row]
        switchView.isOn = selectedTitles[key] ?? false
        return switchView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath)
        let title = cellTitles[indexPath.row]
        cell.textLabel?.text = title.rawValue
        cell.backgroundColor = UIColor(named: "ColorBackground")
        cell.accessoryView = createSwitch(index: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case cellTitles.count - 1:
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        default:
            break
        }
        
        return cell
        
    }
}


