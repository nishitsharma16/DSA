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
    
    func createBSTFromPreorder(preOrder : [Int]) -> BSTNode<ItemType>? {
        if preOrder.isEmpty {
            return nil
        }
        
        let root = BSTNode<Int>(val: preOrder[0])
        let stack = Stack<BSTNode<Int>>()
        stack.push(val: root)
        
        var temp : BSTNode<Int>?
        
        for index in 1..<preOrder.count {
            
            let currentNode = BSTNode<Int>(val : preOrder[index])
            
            if let topVal = stack.top() {
                while !stack.isEmpty && topVal.value < currentNode.value {
                    temp = stack.pop()
                }
                
                if let tempVal = temp {
                    tempVal.right = currentNode
                }
                else {
                    if let topVal = stack.top() {
                        if topVal.value > currentNode.value {
                            topVal.left = currentNode
                        }
                        else {
                            topVal.right = currentNode
                        }
                    }
                }
                stack.push(val: currentNode)
            }
        }
        
        return root
    }
    
    func storeInorder(root : inout BSTNode<ItemType>?, output : inout [Int]) {
        if let rootVal = root {
            storeInorder(root: &rootVal.left, output: &output)
            output.append(rootVal.value)
            storeInorder(root: &rootVal.right, output: &output)
        }
    }
    
    func putInOrderValues(root : inout BSTNode<ItemType>?, output : inout [Int], index : inout Int) {
        if let rootVal = root {
            putInOrderValues(root: &rootVal.left, output: &output, index: &index)
            rootVal.value = output[index]
            index += 1
            putInOrderValues(root: &rootVal.right, output: &output, index: &index)
        }
    }
    
    func convertBinaryTreeToBST(root : inout BSTNode<ItemType>?) {
        
        var inorderValList = [Int]()
        storeInorder(root: &root, output: &inorderValList)
        
        inorderValList = inorderValList.sorted()
        
        var index = 0
        putInOrderValues(root: &root, output: &inorderValList, index: &index)
    }
    
    func delete(root: BSTNode<ItemType>?, key: Int) -> BSTNode<ItemType>? {
        if root == nil {
            return root
        }
        
        // Go let or right to search
        if let x = root?.value, x < key {
            root?.left = delete(root: root?.left, key: key)
        }
        else if let x = root?.value, x > key {
            root?.right = delete(root: root?.right, key: key)
        }
        else {
            // Root Found
            var temp: BSTNode<ItemType>?
            if root?.left == nil {
                temp = root?.right
                root?.value = temp?.value ?? 0
                temp = nil
            }
            else if root?.right == nil {
                temp = root?.left
                root?.value = temp?.value ?? 0
                temp = nil
            }
            
            let succParent: BSTNode<ItemType>? = root
            var succ: BSTNode<ItemType>? = root?.right
            
            while succ?.left != nil {
                succ = succ?.left
            }
            
            if succParent === root {
                succParent?.right = succ?.right
            }
            else {
                succParent?.left = succ?.right
            }
            
            succ = nil
        }
        return root
    }
}

extension BSTNode: Equatable where Item : Equatable {
    static func == (lhs: BSTNode<Item>, rhs: BSTNode<Item>) -> Bool {
        return lhs.value == rhs.value
    }
}
