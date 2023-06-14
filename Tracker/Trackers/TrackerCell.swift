//
//  TrackerCell.swift
//  Tracker
//
//  Created by Алиса Долматова on 06.06.2023.
//

import Foundation
import WebKit
import UIKit


class TrackerCall:UICollectionViewCell{
    
    let viewCell = UIView()
    let cellFooterContainer = UIView()
    var uiLableTitle: UILabel!
    var uiImagePlusButton: UIImageView!
    var uiLableDay: UILabel!
    var uiLableEmoji: UILabel!
    
    
    func setupCell (tracker: Tracker, daysCount: Int) {
        contentView.addSubview(viewCell)
        viewCell.translatesAutoresizingMaskIntoConstraints = false
        viewCell.layer.cornerRadius = 16
        viewCell.layer.masksToBounds = true
        viewCell.backgroundColor = UIColor(named: "ColorSelection5")
       
       NSLayoutConstraint.activate([
        
        viewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
        viewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
        viewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
    
        ])
        setupCellContent(tracker: tracker, daysCount: daysCount)
        setupViewCellContent(tracker: tracker)
    }
    
    private func setupCellContent(tracker: Tracker, daysCount: Int) {
        
        contentView.addSubview(cellFooterContainer)
        cellFooterContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
         
            cellFooterContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            cellFooterContainer.topAnchor.constraint(equalTo: viewCell.bottomAnchor, constant: 0),
            cellFooterContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            cellFooterContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
         
         ])
        
        
        uiLableDay = UILabel()
        cellFooterContainer.addSubview(uiLableDay)
        uiLableDay.translatesAutoresizingMaskIntoConstraints = false
        uiLableDay.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        uiLableDay.textColor = UIColor.black
        uiLableDay.text = String(daysCount)
        
        NSLayoutConstraint.activate([
            uiLableDay.leadingAnchor.constraint(equalTo: cellFooterContainer.leadingAnchor, constant: 12),
            uiLableDay.topAnchor.constraint(equalTo: cellFooterContainer.topAnchor, constant: 16),
            uiLableDay.bottomAnchor.constraint(equalTo: cellFooterContainer.bottomAnchor, constant: -24)
        
        ])
        
        let uiPlusButton = UIButton.systemButton(with: UIImage(named:"circlePlusButton")!, target: self, action: #selector(Self.didTapButton))
        
        cellFooterContainer.addSubview(uiPlusButton)
        uiPlusButton.translatesAutoresizingMaskIntoConstraints = false
        uiPlusButton.tintColor = UIColor.black //TODO цвет должен зависеть от цвета viewCell
        
        NSLayoutConstraint.activate([
            uiPlusButton.widthAnchor.constraint(equalToConstant: 34),
            uiPlusButton.heightAnchor.constraint(equalToConstant: 34),
            uiPlusButton.trailingAnchor.constraint(equalTo: cellFooterContainer.trailingAnchor, constant: -12),
            uiPlusButton.leadingAnchor.constraint(equalTo: uiLableDay.trailingAnchor, constant: 8),
            uiPlusButton.topAnchor.constraint(equalTo: cellFooterContainer.bottomAnchor, constant: 8),
            uiPlusButton.bottomAnchor.constraint(equalTo: cellFooterContainer.bottomAnchor, constant: -16)
        ])
        
    }
        
    
    
private func setupViewCellContent(tracker: Tracker) {
    
    uiLableEmoji = UILabel()
    
    uiLableEmoji = UILabel()
    viewCell.addSubview(uiLableEmoji)
    uiLableEmoji.translatesAutoresizingMaskIntoConstraints = false
    uiLableEmoji.layer.cornerRadius = 12
    uiLableEmoji.layer.masksToBounds = true
    uiLableEmoji.backgroundColor = UIColor(named: "ColorEmojiLable")
    uiLableEmoji.text = tracker.emoji
    uiLableEmoji.textAlignment = .center
    
    NSLayoutConstraint.activate([
        uiLableEmoji.widthAnchor.constraint(equalToConstant: 24),
        uiLableEmoji.heightAnchor.constraint(equalToConstant: 24),
        uiLableEmoji.topAnchor.constraint(equalTo: viewCell.topAnchor, constant: 12),
        uiLableEmoji.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: 12)
        
    ])

    uiLableTitle = UILabel()
    viewCell.addSubview(uiLableTitle)
    uiLableTitle.translatesAutoresizingMaskIntoConstraints = false
    uiLableTitle.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    uiLableTitle.textColor = UIColor.white
    uiLableTitle.text = tracker.name
    uiLableTitle.contentMode = .bottomLeft
    uiLableTitle.numberOfLines = 2
    
    NSLayoutConstraint.activate([
        uiLableTitle.leadingAnchor.constraint(equalTo: viewCell.leadingAnchor, constant: 12),
        uiLableTitle.trailingAnchor.constraint(equalTo: viewCell.trailingAnchor, constant: -12),
        uiLableTitle.bottomAnchor.constraint(equalTo: viewCell.bottomAnchor, constant: -12),
        uiLableTitle.topAnchor.constraint(greaterThanOrEqualTo: uiLableEmoji.bottomAnchor, constant: 8)
    ])
    
}
    
    @objc
    private func didTapButton(){
        // TODO дописать сюда логику нажатия на круглую кнопку с плюсом
    }
        
} // конец класса TrackerCall





