//
//  ItemTableViewCell.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/21/22.
//

import UIKit

protocol ItemCellDelegate {
    func completeButtonPressed(item: Item)
}

class ItemTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ItemTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var completedButton: UIButton!
    
    
    var item: Item?
    var delegate: ItemCellDelegate?
    
    private let checkedImage = UIImage(systemName: "checkmark.square.fill")
    private let squareImage = UIImage(systemName: "square")

    
    func update(with item: Item) {
        self.item = item
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        let image = item.isCompleted ? checkedImage : squareImage
        completedButton.setImage(image, for: .normal)
    }
    
    @IBAction func completeButtonPressed(_ sender: UIButton) {
                guard let item else { return }
                delegate?.completeButtonPressed(item: item)
    }
    
}
