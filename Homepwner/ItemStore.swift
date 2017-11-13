//
//  ItemStore.swift
//  Homepwner
//
//  Created by TuyenVX on 11/10/17.
//  Copyright © 2017 TuyenVX. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
//    init() {
//        for _ in 0..<5 {
//            createItem()
//        }
//    }
    func removeItem(_ item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let moveItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(moveItem, at: toIndex)
    }
}
