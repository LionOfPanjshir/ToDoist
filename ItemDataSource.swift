//
//  ItemDataSource.swift
//  ToDoist
//
//  Created by Andrew Higbee on 11/29/23.
//

import Foundation
import UIKit

protocol ItemDelegate {
    func deleteItem(at indexPath: IndexPath)
}

class ItemDataSource: UITableViewDiffableDataSource<ItemsViewController.TableSection, Item> {
    
    var delegate: ItemDelegate?
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tableSection = ItemsViewController.TableSection(rawValue: section)!
        switch tableSection {
        case .incomplete:
            return "To Do"
        case .complete:
            return "Completed"
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        delegate?.deleteItem(at: indexPath)
    }
    
}
