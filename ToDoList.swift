//
//  ToDoList.swift
//  ToDoist
//
//  Created by Andrew Higbee on 11/28/23.
//

import Foundation

extension ToDoList {
    var itemsArray: [Item] {
        let array = items?.allObjects as? [Item]
        return array ?? []
    }
}
