//
//  LaunchScreen.swift
//  Tracker
//
//  Created by Алиса Долматова on 05.06.2023.
//

import Foundation
import WebKit
import UIKit


class LaunchScreen: UIViewController  {
    
    var uiImage:UIImageView!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(named: "LSBlue")
        setupViews()
        switchToController(vc: OnbordingUIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal))
    }
    
    
    private func setupViews() {
        
        let logoImage = UIImage(named: "Logo")
        
        uiImage = UIImageView()
        
        view.addSubview(uiImage)
        uiImage.translatesAutoresizingMaskIntoConstraints = false
        uiImage.image = logoImage
        
        
        NSLayoutConstraint.activate([
            uiImage.widthAnchor.constraint(equalToConstant: 94),
            uiImage.heightAnchor.constraint(equalToConstant: 91),
            uiImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            uiImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
}
