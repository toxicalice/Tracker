//
//  AddNewCategoryViewController.swift
//  Tracker
//
//  Created by Алиса Долматова on 12.06.2023.
//

import Foundation
import UIKit

class AddNewCategoryViewController: UIViewController {
    
    var uiHeaderLable: UILabel!
    var uiTextField: UITextField!
    var trackerName:String? = nil
    let uiButtonReady = UIButton()
    
    override func viewDidLoad() {
        setupViews()
        
    }
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        uiHeaderLable = UILabel()
        
        view.addSubview(uiHeaderLable)
        uiHeaderLable.translatesAutoresizingMaskIntoConstraints = false
        uiHeaderLable.text = "Новая категория"
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
        
        
        
        uiButtonReady.addTarget(self, action: #selector(Self.didTapButtonuReady), for: .touchUpInside)
        
        view.addSubview(uiButtonReady)
        uiButtonReady.translatesAutoresizingMaskIntoConstraints = false
        uiButtonReady.backgroundColor = .black
        uiButtonReady.setTitle("Готово", for: .normal)
        uiButtonReady.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        uiButtonReady.tintColor = .white
        uiButtonReady.layer.cornerRadius = 16
        uiButtonReady.isEnabled = false
        
        NSLayoutConstraint.activate([
            uiButtonReady.heightAnchor.constraint(equalToConstant: 60),
            uiButtonReady.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            uiButtonReady.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            uiButtonReady.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    @objc
    private func didTapButtonuReady() {
        
        
      //TODO Если введен хотя бы 1 символ, то кнопка «Готово» становится активной При нажатии на кнопку «Готово» открывается экран выбора категории. Созданная категория отмечена синей галочкой;
    }
    
    @objc
    private func textChanged(_ textField: UITextField) {
        trackerName = textField.text
        if let trackerName = trackerName, !trackerName.isEmpty {
            uiButtonReady.isEnabled = true
        } else {
            uiButtonReady.isEnabled = false
        }
    }
    
} //конец класса AddNewCategoryViewController
