//
//  ToDoListsTableViewController.swift
//  ToDoist
//
//  Created by Andrew Higbee on 12/1/23.
//

import UIKit

class ToDoListsTableViewController: UITableViewController {
    
    private let manager = ItemManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    func list(at indexPath: IndexPath) -> ToDoList {
        manager.allLists()[indexPath.row]
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return manager.allLists().count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath)
        let listAtRow = list(at: indexPath)
        cell.textLabel?.text = listAtRow.title
        cell.detailTextLabel?.text = "\(listAtRow.itemsArray.count) items"
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        manager.deleteList(at: indexPath)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
    @IBAction func presentNewListAlert(_ sender: Any) {
        let alert = UIAlertController(title: "Create a New ToDoList", message: nil, preferredStyle: .alert)
        alert.addTextField { tf in tf.placeholder = "List name: "}
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned alert] _ in guard let textField = alert.textFields?.first, let response = textField.text else { return }
            self.manager.createNewList(with: response)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @IBSegueAction func showItems(_ coder: NSCoder) -> ItemsViewController? {
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedList = list(at: indexPath)
        return ItemsViewController(code: coder, list: selectedList)
    }
}
