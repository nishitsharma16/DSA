//
//  BinaryTree.swift
//  DSA
//
//  Created by Nishit on 14/05/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class BTNode<Item> {
    var left : BTNode<Item>?
    var right : BTNode<Item>?
    var value : Item
    init(val : Item) {
        value = val
    }
}

class BinaryTree {
    
    func minMaxHorizontalDistance(root : BTNode<Item<Int>>?, min : inout Int, max : inout Int, hd : inout Int) {
        if let rootVal = root {
            
            if hd < min {
                min = hd
            }
            else if hd > max {
                max = hd
            }
            
            hd = hd - 1
            minMaxHorizontalDistance(root: rootVal.left, min: &min, max: &max, hd: &hd)
            hd = hd + 1
            minMaxHorizontalDistance(root: rootVal.right, min: &min, max: &max, hd: &hd)
        }
    }
    
    func printVerticatNodes(root : BTNode<Item<Int>>?, line : inout Int, hd : inout Int) {
        
        if let rootVal = root {
            if line == hd {
                print("val : \(rootVal.value)")
            }
            
            hd = hd - 1
            printVerticatNodes(root: rootVal.left, line: &line, hd: &hd)
            hd = hd + 1
            printVerticatNodes(root: rootVal.right, line: &line, hd: &hd)
        }
    }
    
    func printVerticalOrder(root : BTNode<Item<Int>>?) {
        
        var min = 0
        var max = 0
        var hd = 0
        
        minMaxHorizontalDistance(root: root, min: &min, max: &max, hd: &hd)
        
        while min <= max {
            hd = 0
            printVerticatNodes(root: root, line: &min, hd: &hd)
            min += 1
        }
    }
}
