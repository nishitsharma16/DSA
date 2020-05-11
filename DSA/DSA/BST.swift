//
//  BST.swift
//  DSA
//
//  Created by Nishit on 11/05/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class BSTNode<Item> {
    var left : BSTNode<Item>?
    var right : BSTNode<Item>?
    let value : Item
    init(val : Item) {
        value = val
    }
}

class BST<ItemType> {
    
    func inOrder(root : BSTNode<ItemType>?) {
        if let rootVal = root {
            inOrder(root: rootVal.left)
            print("Val : \(rootVal.value)")
            inOrder(root: rootVal.right)
        }
    }
    
    func preOrder(root : BSTNode<ItemType>?) {
        if let rootVal = root {
            print("Val : \(rootVal.value)")
            inOrder(root: rootVal.left)
            inOrder(root: rootVal.right)
        }
    }
    
    func postOrder(root : BSTNode<ItemType>?) {
        if let rootVal = root {
            inOrder(root: rootVal.left)
            inOrder(root: rootVal.right)
            print("Val : \(rootVal.value)")
        }
    }
    
    func createMaxSumTree(root : BSTNode<ItemType>?) {
        if let rootVal = root {
            createMaxSumTree(root: rootVal.right)
            
        }
    }
}
