//
//  EditViewController.swift
//  Tracker
//
//  Created by Алиса Долматова on 08.10.2023.
//

import Foundation
import UIKit

protocol EditViewControllerDelegat {
    func editTracker(category:String, tracker:Tracker)
}

class EditViewController:UIViewController, AddCategoryDelegate, AddNewTimeTableDelegate, EmojiCellDelegate, ColorCellDelegate {
    
    var uiHeaderLable: UILabel!
    var uiDaysLable: UILabel!
    var uiTextField: UITextField!
    var tableView: UITableView!
    let idCell = "cell"
    let callTitles = ["Категория","Расписание"]
    var trackerName:String? = nil
    let uiButtonSave = UIButton()
    var trackersVCdelegate: EditViewControllerDelegat? = nil
    var selectedCategory: String?
    var selectedDay: [Tracker.Ordinary] = []
    var selectedEmoji: String?
    var selectedColor: UIColor?
    var tracker:Tracker?
    var category: String?
    var days:Int?
    
    
    
    override func viewDidLoad() {
        setupViews(daysCount: days ?? 0)
        tableView.register(SupplementaryTableView.self, forCellReuseIdentifier: "customTableCell")
        uiTextField.delegate = self
        addTapGestureToHideKeyboard()
        uiTextField.text = tracker?.name
        selectedCategory = category
        selectedDay = tracker?.ordinary ?? []
        selectedEmoji = tracker?.emoji
        selectedColor = tracker?.color
        textChanged(uiTextField)
    }
    
    private func setupViews(daysCount: Int) {
        
        view.backgroundColor = .white
        
        uiHeaderLable = UILabel()
        
        view.addSubview(uiHeaderLable)
        uiHeaderLable.translatesAutoresizingMaskIntoConstraints = false
        uiHeaderLable.text = "Редактирование привычки"
        uiHeaderLable.textColor = UIColor.black
        uiHeaderLable.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        uiHeaderLable.textAlignment = .center
        
        
        NSLayoutConstraint.activate([
            uiHeaderLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            uiHeaderLable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
        ])
        
        uiDaysLable = UILabel()
        view.addSubview(uiDaysLable)
        uiDaysLable.translatesAutoresizingMaskIntoConstraints = false
        uiDaysLable.text = String.localizedStringWithFormat(
            NSLocalizedString("numberOfDays", comment: ""),
            daysCount
            )
        uiDaysLable.textColor = UIColor(named: "Black")
        uiDaysLable.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        NSLayoutConstraint.activate([
            uiDaysLable.topAnchor.constraint(equalTo: uiHeaderLable.bottomAnchor, constant: 38),
            uiDaysLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 136),
            uiDaysLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 136)
        ])
        
        
        uiTextField = PaddedTextFeild()
        view.addSubview(uiTextField)
        uiTextField.translatesAutoresizingMaskIntoConstraints = false
        uiTextField.placeholder = NSLocalizedString("newHabit.uiTextField", comment: "")
        uiTextField.layer.cornerRadius = 16
        uiTextField.backgroundColor = UIColor(named: "ColorBackground")
        uiTextField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
        
        NSLayoutConstraint.activate([
            uiTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            uiTextField.topAnchor.constraint(equalTo: uiDaysLable.bottomAnchor, constant: 38),
            uiTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            uiTextField.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        
        tableView = UITableView(frame: CGRect(), style: .grouped)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: idCell)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
    
    
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.topAnchor.constraint(equalTo: uiTextField.bottomAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 400)
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
        uiButtonCancel.setTitle(NSLocalizedString("newHabit.uiButtonCancel", comment: ""), for: .normal)
        uiButtonCancel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        uiButtonCancel.setTitleColor(UIColor(named: "ColorRed"), for: .normal)
        uiButtonCancel.layer.borderColor = UIColor(named: "ColorRed")?.cgColor
        uiButtonCancel.layer.borderWidth = 1
        uiButtonCancel.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            uiButtonCancel.heightAnchor.constraint(equalToConstant: 60)
        ])
        
       
        uiButtonSave.addTarget(self, action: #selector(Self.didTapButtonCreate), for: .touchUpInside)
        
        uiButtonSave.translatesAutoresizingMaskIntoConstraints = false
        uiButtonSave.backgroundColor = UIColor(named: "ColorGray")
        uiButtonSave.setTitle("Сохранить", for: .normal)
        uiButtonSave.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        uiButtonSave.tintColor = .white
        uiButtonSave.layer.cornerRadius = 16
        uiButtonSave.isEnabled = false

        NSLayoutConstraint.activate([
            uiButtonSave.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        stack.addArrangedSubview (uiButtonCancel)
        stack.addArrangedSubview (uiButtonSave)
        stack.axis = .horizontal
    }
    
    @objc
    private func textChanged(_ textField: UITextField) {
        trackerName = textField.text
        if let trackerName = trackerName, !trackerName.isEmpty {
            uiButtonSave.isEnabled = true
            uiButtonSave.backgroundColor = UIColor(named: "ColorBlack")

        } else {
            uiButtonSave.isEnabled = false
            uiButtonSave.backgroundColor = UIColor(named: "ColorGray")
        }
    }
    
    @objc
    private func didTapButtonCancel() {
        dismiss(animated: true)
    }
    
    @objc
    private func didTapButtonCreate() {
        guard let selectedCategory = selectedCategory else {return}
        guard let id = tracker?.id else {return}
        guard let trackerName = trackerName else {return}
        guard let selectedEmoji = selectedEmoji else {return}
        guard let selectedColor = selectedColor else {return}
        trackersVCdelegate?.editTracker(category: selectedCategory, tracker: Tracker(id: id, name: trackerName, color: selectedColor, emoji: selectedEmoji, ordinary: selectedDay))
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
    
    func addEmoji(emoji: String) {
        selectedEmoji = emoji
        tableView.reloadData()
    }
    
    func addColor(color: UIColor) {
        selectedColor = color
        tableView.reloadData()
    }
    
   
    
} //конец класса NewHabitViewController


extension EditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section) {
            
        case 0:
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
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 75
        default: return 200
        }
    }
   
}

extension EditViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 1
        case 2: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: idCell)
            let title = callTitles[indexPath.row]
            cell.textLabel?.text = title
            cell.backgroundColor = .clear
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = UIColor(named: "ColorBackground")
           
            if indexPath.row == 0 {
                cell.detailTextLabel?.text = selectedCategory
                cell.detailTextLabel?.textColor = UIColor(named: "ColorGray")
                cell.layer.masksToBounds = true
                cell.layer.cornerRadius = 16
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                let viewSeparator = UIView()
                cell.contentView.addSubview(viewSeparator)
                viewSeparator.translatesAutoresizingMaskIntoConstraints = false
                viewSeparator.backgroundColor = .gray
                
                NSLayoutConstraint.activate([
                    viewSeparator.leadingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                    viewSeparator.topAnchor.constraint(equalTo: cell.bottomAnchor, constant: 0),
                    viewSeparator.trailingAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                    viewSeparator.heightAnchor.constraint(equalToConstant: 1)
                ])
            } else {
                if !selectedDay.isEmpty {
                    var text =  ""
                    selectedDay.forEach { day in
                        text += "\(day.shortText()), "
                    }
                    text = String(text.dropLast(2))
                    cell.detailTextLabel?.text = text
                    cell.detailTextLabel?.textColor = UIColor(named: "ColorGray")
                    cell.layer.masksToBounds = true
                    cell.layer.cornerRadius = 16

                    cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                }
            }
            
            return cell
        case 1:
            let cell = EmojiCell()
                cell.delegat = self
                cell.selectedEmoji = selectedEmoji
                cell.prepareForReuse()
                cell.setup()
                return cell
        default:
                let cell = ColorCell()
                cell.delegat = self
                cell.selectedColor = selectedColor
                cell.prepareForReuse()
                cell.setup()
                return cell
          
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "customTableCell") as! SupplementaryTableView
        headerView.addSubview(headerCell)
    
        switch section {
        case 0:
            return nil
            
        case 1:
            headerCell.titleLabel.text = NSLocalizedString("newHabit.headerCell.titleLabel.emoji", comment: "")
            return headerView
            
        case 2:
            headerCell.titleLabel.text = NSLocalizedString("newHabit.headerCell.titleLabel.color", comment: "")
            return headerView
            
        default:
            return headerView
        }
    }
} // конец класса EditViewController


extension EditViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        uiTextField.resignFirstResponder()
        return true
    }
}


