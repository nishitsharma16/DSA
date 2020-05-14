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
    var value : Item
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
}

extension BST where ItemType == Int {
    
    func createMaxSumTreeSet1(root : BSTNode<ItemType>?, sum : inout Int) {
        if let rootVal = root {
            createMaxSumTreeSet1(root: rootVal.right, sum: &sum)
            sum = sum + rootVal.value
            rootVal.value = sum - rootVal.value
            createMaxSumTreeSet1(root: rootVal.left, sum: &sum)
        }
    }
    
//    func createMaxSumTreeSet2(root : BSTNode<ItemType>?) -> BSTNode<ItemType>? {
//        
//        if root == nil {
//            return nil
//        }
//        else {
//            var x = createMaxSumTreeSet2(root: root?.right)
//            x?.value = 
//        }
//    }
}
