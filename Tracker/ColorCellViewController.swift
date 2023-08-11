
//
//  EmojiCellViewController.swift
//  Tracker

import Foundation
import UIKit

protocol ColorCellDelegate {
    func addColor (color: UIColor)
}

class ColorCellViewController: UITableViewCell {
    
    var colors = [
        UIColor(hex: "#FD4C49"),
                  UIColor(hex: "#FF881E"),
                  UIColor(hex: "#007BFA"),
                  UIColor(hex: "#6E44FE"),
                  UIColor(hex: "#33CF69"),
                  UIColor(hex: "#E66DD4"),
                  UIColor(hex: "#F9D4D4"),
                  UIColor(hex: "#34A7FE"),
                  UIColor(hex: "#46E69D"),
                  UIColor(hex: "#35347C"),
                  UIColor(hex: "#FF674D"),
                  UIColor(hex: "#FF99CC"),
                  UIColor(hex: "#F6C48B"),
                  UIColor(hex: "#7994F5"),
                  UIColor(hex: "#832CF1"),
                  UIColor(hex: "#AD56DA"),
                  UIColor(hex: "#8D72E6"),
                  UIColor(hex: "#2FD058")
    ]
    
    var viewCell: UIView!
    var cellHeaderContainer: UIView!
    var delegat: ColorCellDelegate? = nil
    var selectedColor: UIColor?
    
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
            let colorStack = createStack()
            stack.addArrangedSubview(colorStack)
                for rowIndex in 0...2 {
                         let flatIndex = columnIndex + (6 * rowIndex)
                    let color = colors[flatIndex]
                        let createViews = createViews(color: color!)
                        colorStack.addArrangedSubview(createViews)
                    if createViews.layer.borderColor == selectedColor?.cgColor {
                        createViews.layer.borderWidth = 3
                    } else {createViews.layer.borderWidth = 0}
                }
          }
        }
        
        func createViews(color: UIColor) -> UIView {
            
            
            let colorBorderView = UIView()
            colorBorderView.translatesAutoresizingMaskIntoConstraints = false
            colorBorderView.isUserInteractionEnabled = true
            colorBorderView.backgroundColor = .clear
            colorBorderView.layer.cornerRadius = 10
            colorBorderView.clipsToBounds = true
            colorBorderView.layer.borderColor = color.cgColor // TODO унизить альфа канал (как??)
            colorBorderView.layer.borderWidth = 0
            
            NSLayoutConstraint.activate([
                colorBorderView.heightAnchor.constraint(equalToConstant: 52),
                colorBorderView.widthAnchor.constraint(equalToConstant: 52)
            ])
            
            let colorView = UIView()
            colorBorderView.addSubview(colorView)
            colorView.translatesAutoresizingMaskIntoConstraints = false
            let gesture = UITapGestureRecognizer(target: self, action: #selector(colorDidTap(_:)))
            colorView.addGestureRecognizer(gesture)
            colorView.isUserInteractionEnabled = true
            colorView.backgroundColor = color
            colorView.layer.cornerRadius = 8
            colorView.clipsToBounds = true
            
            
            NSLayoutConstraint.activate([
                colorView.heightAnchor.constraint(equalToConstant: 40),
                colorView.widthAnchor.constraint(equalToConstant: 40),
                colorView.centerXAnchor.constraint(equalTo: colorBorderView.centerXAnchor),
                colorView.centerYAnchor.constraint(equalTo: colorBorderView.centerYAnchor)

            ])
            
            return colorBorderView
        }
        
        func createStack() -> UIStackView {
            let colorStack = UIStackView()
            colorStack.translatesAutoresizingMaskIntoConstraints = false
            colorStack.distribution = .fillEqually
            colorStack.alignment = .fill
            colorStack.spacing = 0
            colorStack.axis = .vertical
            
            return colorStack
        }
        
        @objc
        func colorDidTap(_ sender: UITapGestureRecognizer) {
            let view = (sender.view)
            delegat?.addColor(color: view?.backgroundColor ?? .clear)
            
        }
    
} // конец класса EmojiCellViewController


