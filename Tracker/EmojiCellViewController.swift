//
//  EmojiCellViewController.swift
//  Tracker
//
//  Created by Алиса Долматова on 13.07.2023.
//

import Foundation
import UIKit

protocol EmojiCellDelegate {
    func addEmoji (emoji: String)
}

class EmojiCellViewController: UITableViewCell {
    
    var emoji = ["🙂","😻","🌺","😇","😡","🥶","🤔","🥦","🏓","🥇","🎸","🐶","❤️","😱","🙌","🍔","🏝", "😪"]
    
    var viewCell: UIView!
    var cellHeaderContainer: UIView!
    var delegat: EmojiCellDelegate? = nil
    var selectedEmoji: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        viewCell = UIView()
        contentView.addSubview(viewCell)
        viewCell.translatesAutoresizingMaskIntoConstraints = false
        viewCell.layer.cornerRadius = 16
        viewCell.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            
            viewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            viewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            viewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
            
        ])
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        setupCellContent()
        setupViewCellContent()
    }
    
    
    private func setupCellContent() {
        
        cellHeaderContainer = UIView()
        contentView.addSubview(cellHeaderContainer)
        cellHeaderContainer.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            cellHeaderContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            cellHeaderContainer.topAnchor.constraint(equalTo: viewCell.bottomAnchor, constant: 0),
            cellHeaderContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            cellHeaderContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupViewCellContent() {
        let stack = UIStackView()
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.spacing = 5
        
        NSLayoutConstraint.activate([
            stack.heightAnchor.constraint(equalToConstant: 204),
            stack.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            stack.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            stack.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            stack.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 24)
        ])

        for columnIndex in 0...5 {
            let emojiStack = createStack()
            stack.addArrangedSubview(emojiStack)
            for rowIndex in 0...2 {
                let flatIndex = columnIndex + (6 * rowIndex)
                let createLabel = createLabel(emoji: emoji[flatIndex])
                emojiStack.addArrangedSubview(createLabel)
                if createLabel.text == selectedEmoji {
                    createLabel.backgroundColor = UIColor(named: "ColorBackground")
                    createLabel.layer.cornerRadius = 16
                    createLabel.clipsToBounds = true
                }
            }
        }
    }
    
    func createLabel(emoji: String) -> UILabel {
        let emojiLable = UILabel()
        emojiLable.translatesAutoresizingMaskIntoConstraints = false
        emojiLable.text = emoji
        emojiLable.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        emojiLable.textAlignment = .center
        let gesture = UITapGestureRecognizer(target: self, action: #selector(emojiDidTap(_:)))
        emojiLable.addGestureRecognizer(gesture)
        emojiLable.isUserInteractionEnabled = true

         
        NSLayoutConstraint.activate([
            emojiLable.heightAnchor.constraint(equalToConstant: 52),
            emojiLable.widthAnchor.constraint(equalToConstant: 52)
            
        ])
        return emojiLable
    }
    
    func createStack() -> UIStackView {
        let emojiStack1 = UIStackView()
        emojiStack1.translatesAutoresizingMaskIntoConstraints = false
        emojiStack1.distribution = .fillEqually
        emojiStack1.alignment = .fill
        emojiStack1.spacing = 0
        emojiStack1.axis = .vertical
        
        return emojiStack1
    }
    
    @objc
    func emojiDidTap(_ sender: UITapGestureRecognizer) {
        let label = (sender.view as? UILabel)
        delegat?.addEmoji(emoji: label?.text ?? "🌺")
    }
    
} // конец класса EmojiCellViewController
