//
//  ItemManager.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/21/22.
//

import Foundation
import CoreData

class ItemManager {
    static let shared = ItemManager()
    
    private let context = PersistenceController.shared.viewContext
    
    
    // MARK: - Lists
    
    func createNewList(with title: String) {
        let newList = ToDoList(context: context)
        newList.id = UUID().uuidString
        newList.title = title
        newList.createdAt = Date()
        newList.modifiedAt = Date()
        saveContext()
    }
    
    func allLists() -> [ToDoList] {
        let fetchRequest = ToDoList.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "modifiedAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedLists = try? context.fetch(fetchRequest)
        return fetchedLists ?? []
    }
    
    func deleteList(at indexPath: IndexPath) {
        let list = allLists()[indexPath.row]
        context.delete(list)
        saveContext()
    }
    
    
    // MARK: - Items
    
    func createNewItem(with title: String, list: ToDoList) {
        let newItem = Item(context: context)
        newItem.id = UUID().uuidString
        newItem.title = title
        newItem.createdAt = Date()
        newItem.completedAt = nil
        newItem.toDoList = list
        saveContext()
    }
    
    func incompleteItems(of list: ToDoList) -> [Item] {
        let incompleteItems = list.itemsArray.filter { !$0.isCompleted }
        return incompleteItems.sorted(by: { $0.sortDate > $1.sortDate })
    }
    
    func completedItems(of list: ToDoList) -> [Item] {
        let completedItems = list.itemsArray.filter { $0.isCompleted }
        return completedItems.sorted(by: { $0.sortDate > $1.sortDate })
    }
    
    func toggleItemCompletion(_ item: Item) {
        item.completedAt = item.isCompleted ? nil : Date()
        saveContext()
    }
    
    func delete(_ item: Item) {
        let context = context
        context.delete(item)
        saveContext()
    }

    private func saveContext() {
        PersistenceController.shared.saveContext()
    }
    
}
