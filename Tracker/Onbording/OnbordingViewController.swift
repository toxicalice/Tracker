//
//  OnbordingViewController.swift
//  Tracker
//
//  Created by Алиса Долматова on 14.09.2023.
//

import Foundation
import UIKit

class OnbordingViewController: UIViewController {
    
    var uiImage:UIImageView!
    var labelName:UILabel!
    var text:String?
    var image:UIImage?
    
    override func viewDidLoad() {
        setupView()
    }

    private func setupView() {
        uiImage = UIImageView()
        let backImage = image
        
        view.addSubview(uiImage)
        uiImage.translatesAutoresizingMaskIntoConstraints = false
        uiImage.image = backImage
        
        
        NSLayoutConstraint.activate([
            uiImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            uiImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uiImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            uiImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            uiImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            uiImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        ])
        
        
        let uiButtonNext = UIButton()
        uiButtonNext.addTarget(self, action: #selector(Self.didTapButtonuAddCategory), for: .touchUpInside)
        
        view.addSubview(uiButtonNext)
        uiButtonNext.translatesAutoresizingMaskIntoConstraints = false
        uiButtonNext.backgroundColor = .black
        uiButtonNext.setTitle("Вот это технологии!", for: .normal)
        uiButtonNext.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        uiButtonNext.tintColor = .white
        uiButtonNext.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            uiButtonNext.heightAnchor.constraint(equalToConstant: 60),
            uiButtonNext.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            uiButtonNext.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            uiButtonNext.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -84)
        ])
        
        labelName = UILabel()
        
        view.addSubview(labelName)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.text = text
        labelName.numberOfLines = 2
        labelName.textAlignment = .center
        labelName.textColor = UIColor.black
        labelName.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 25),
            labelName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            labelName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            labelName.bottomAnchor.constraint(lessThanOrEqualTo: uiButtonNext.topAnchor, constant: -16)
        ])
    }
    
    
    @objc
    private func didTapButtonuAddCategory() {
        switchToController(vc: TrackersViewController())
    }
}






