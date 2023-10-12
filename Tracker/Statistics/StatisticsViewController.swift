//
//  StatisticsViewController.swift
//  Tracker
//
//  Created by Алиса Долматова on 12.10.2023.
//

import Foundation
import UIKit

final class StatisticsViewController: UIViewController {
            
    var statisticsNumber = 0
    
    let store = StatisticsStore()
    
    var statistics: Statistics?
    
    private func getStatistics() {
        let result = Statistics(endedTracks: store.getStatistics())
        statistics = result
    }
    
    let statisticsLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("StatisticsViewController.title", comment: "")
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let faceImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "statsPlaceholder"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("StatisticsViewController.placeholderTitle", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 8.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let statisticsTable: UITableView = {
        let table = UITableView()
        table.register(StatisticsCell.self, forCellReuseIdentifier: "statisticsCell")
        table.isScrollEnabled = false
        table.separatorStyle = .none
        table.allowsSelection = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getStatistics()
        updateView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            statisticsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statisticsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statisticsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statisticsTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statisticsTable.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statisticsTable.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    private func setupViews() {
        view.addSubview(statisticsLabel)
        view.addSubview(stackView)
        view.addSubview(statisticsTable)
        stackView.addArrangedSubview(faceImage)
        stackView.addArrangedSubview(questionLabel)
        statisticsTable.dataSource = self
        statisticsTable.delegate = self
    }
    
    private func updateView() {
            if let statistics = statistics, statistics.endedTracks > 0 {
                self.stackView.isHidden = true
                self.statisticsTable.isHidden = false
                self.statisticsNumber = statistics.endedTracks
                self.statisticsTable.reloadData()
            } else {
                self.stackView.isHidden = false
                self.statisticsTable.isHidden = true
                self.statisticsTable.reloadData()
            }
    }
    
}

extension StatisticsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statisticsCell", for: indexPath)
        guard let statisticsCell = cell as? StatisticsCell else { return UITableViewCell() }
        statisticsCell.numberLabel.text = "\(statisticsNumber)"
        return statisticsCell
    }
    
}

extension StatisticsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
