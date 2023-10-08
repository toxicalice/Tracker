//
//  ViewController.swift
//  Tracker
//
//  Created by Алиса Долматова on 26.05.2023.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trackersViewController = TrackersViewController()
        let statisticViewController = StatisticViewController()
        trackersViewController.title = NSLocalizedString("tabView.trackersViewController.title", comment: "")
        statisticViewController.title = NSLocalizedString("tabView.statisticViewController.title", comment: "")
        
        self.setViewControllers([trackersViewController, statisticViewController], animated: false)
        
        guard let items = self.tabBar.items else {return}
        
        let images = ["TabBarTracker", "TabBarStatistic"]
        
        for a in 0...1 {
            items[a].image = UIImage(named: images[a])
        }
        self.tabBar.tintColor = UIColor(named: "Blue")
    }


}

