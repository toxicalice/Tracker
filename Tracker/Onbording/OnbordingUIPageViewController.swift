//
//  OnbordingUIPageViewController.swift
//  Tracker
//
//  Created by Алиса Долматова on 14.09.2023.
//

import Foundation
import UIKit

class OnbordingUIPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    lazy var pages:[UIViewController] = {
        let first = OnbordingViewController()
        let second = OnbordingViewController()
        first.text = NSLocalizedString("onbording.first.text", comment: "")
        first.image = UIImage(named: "background1")
        second.text = NSLocalizedString("onbording.second.text", comment: "")
        second.image = UIImage(named: "background2")
        return [first,second]
    }()
    
    override func viewDidLoad() {
            super.viewDidLoad()
        dataSource = self 
            
            if let first = pages.first {
                setViewControllers([first], direction: .forward, animated: true, completion: nil)
            }
        }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        switch pages.firstIndex(of: viewController) {
        case 0: return nil
        case 1: return pages[0]
        default: return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        switch pages.firstIndex(of: viewController) {
        case 0: return pages[1]
        case 1: return nil
        default: return nil
        }
    }
    
    
}
