//
//  UIViewControllerExtension.swift
//  Tracker
//
//  Created by Алиса Долматова on 08.06.2023.
//

import Foundation
import UIKit

extension UIViewController {
   func switchToController(vc: UIViewController) {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        window.rootViewController = vc
    }
}
