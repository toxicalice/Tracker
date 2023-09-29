//
//  CategoriesViewController.swift
//  Tracker
//
//  Created by Алиса Долматова on 12.06.2023.
//

import Foundation
import UIKit

protocol AddCategoryDelegate {
    func categorySelected (name: String)
}


class CategoriesViewController: UIViewController, AddNewCategoryViewControllerDelegate {
   
    var uiHeaderLable: UILabel!
    var uiEmptyPlaceholder: UIImageView!
    var lableEmpty: UILabel!
    var tableView: UITableView!
    let idCell = "cell"
   
    var delegate: AddCategoryDelegate?
    var categoriesViewModel = CategoriesViewModel()
    
    
    override func viewDidLoad() {
        setupViews()
        setupEmptyPlaceholder()
        setupTableView()
        categoriesViewModel.getCategory()

        categoriesViewModel.onChangeCellTitles = { [weak self] in
            guard let self = self else {return}
            toggleVisibility(flag: categoriesViewModel.cellTitles.isEmpty)
        }
        
        categoriesViewModel.onChangeSelectedCategory = { [weak self] in
                guard let self = self else {return}
                tableView.reloadData()
        }
    }
    
    func toggleVisibility (flag: Bool) {
        if flag == true {
            uiEmptyPlaceholder.isHidden = false
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
            uiEmptyPlaceholder.isHidden = true
            tableView.reloadData()
        }
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
        lableEmpty.text = "Привычки и события можно \n объединить по смыслу"
        lableEmpty.textColor = UIColor.black
        lableEmpty.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        lableEmpty.textAlignment = .center
        lableEmpty.numberOfLines = 2
 
        
        NSLayoutConstraint.activate([
            
            lableEmpty.topAnchor.constraint(equalTo: uiEmptyPlaceholder.bottomAnchor, constant: 8),
            lableEmpty.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            lableEmpty.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
            
        ])
        
    }
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        uiHeaderLable = UILabel()
        
        view.addSubview(uiHeaderLable)
        uiHeaderLable.translatesAutoresizingMaskIntoConstraints = false
        uiHeaderLable.text = "Категория"
        uiHeaderLable.textColor = UIColor.black
        uiHeaderLable.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        uiHeaderLable.textAlignment = .center
        
        
        NSLayoutConstraint.activate([
            uiHeaderLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            uiHeaderLable.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0)
        ])
        
       
        let uiButtonAddCategory = UIButton()
        uiButtonAddCategory.addTarget(self, action: #selector(Self.didTapButtonuAddCategory), for: .touchUpInside)
        
        view.addSubview(uiButtonAddCategory)
        uiButtonAddCategory.translatesAutoresizingMaskIntoConstraints = false
        uiButtonAddCategory.backgroundColor = .black
        uiButtonAddCategory.setTitle("Добавить категорию", for: .normal)
        uiButtonAddCategory.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        uiButtonAddCategory.tintColor = .white
        uiButtonAddCategory.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            uiButtonAddCategory.heightAnchor.constraint(equalToConstant: 60),
            uiButtonAddCategory.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            uiButtonAddCategory.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            uiButtonAddCategory.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    func setupTableView() {
        
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: idCell)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.topAnchor.constraint(equalTo: uiHeaderLable.bottomAnchor, constant: 38),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalToConstant: 450)
        ])
        
    }
    
    
    @objc
    func didTapButtonuAddCategory() {
       let addTrackerViewController = AddNewCategoryViewController()
       addTrackerViewController.delegate = self
       present(addTrackerViewController, animated: true)
   }
    
    func addCategory(name: String) {
        categoriesViewModel.addCategory(name: name)
        if tableView == nil {
            setupTableView()
        }
    }
    
} //конец класса CategoriesViewController


extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        categoriesViewModel.updateSelectedCategory(index: indexPath.row)
        tableView.reloadData()
        delegate?.categorySelected(name: categoriesViewModel.cellTitles[indexPath.row])
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
   
}

extension CategoriesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoriesViewModel.cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath)
        let title =   categoriesViewModel.cellTitles[indexPath.row]
        cell.textLabel?.text = title
        cell.backgroundColor = UIColor(named: "ColorBackground")
        
        switch indexPath.row {
        case 0:
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case categoriesViewModel.cellTitles.count - 1:
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        default:
            break
        }
        
        if title == categoriesViewModel.selectedCategory {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    
       return cell
        
    }
}
