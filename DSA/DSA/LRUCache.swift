//
//  LRUCache.swift
//  DSA
//
//  Created by Nishit on 15/06/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class DQNode<ValType> {
    var next : DQNode?
    var prev : DQNode?
    let value : ValType
    init(val : ValType) {
        value = val
    }
}

class DQList<Val> {
    var front : DQNode<Val>?
    var rear : DQNode<Val>?
    let size : Int
    private var nodeCount = 0
    init(sizeVal : Int) {
        size = sizeVal
    }
    
    func sizeOfList() -> Int {
        return nodeCount
    }
    
    func getNode(val : Val) -> DQNode<Val> {
        return DQNode<Val>(val: val)
    }
    
    func insert(val : Val) -> DQNode<Val> {
        let node = getNode(val: val)
        if nodeCount < size {
            insertFromFront(node: node)
        }
        else {
            if let _ = rear {
                var temp = rear
                rear = temp?.prev
                temp = nil
                nodeCount -= 1
            }
            insertFromFront(node: node)
        }
        return node
    }
    
    private func insertFromFront(node :  DQNode<Val>) {
        if let _ = front {
            front?.prev = node
        }
        else {
            rear = node
        }
        front = node
        nodeCount += 1
    }
}

class LRUCache<Key : Hashable, Val> {
    var map = [Key : DQNode<Val>]()
    var dq : DQList<Val>
    let cacheSize : Int
    init(size : Int) {
        cacheSize = size
        dq = DQList(sizeVal: size)
    }
    
    func getNode(kayVal : Key) -> DQNode<Val>? {
        if let node = map[kayVal] {
            return node
        }
        return nil
    }
    
    func insertNode(kayVal : Key, dataVal : Val) {
        if let _ = map[kayVal] {
        }
        else {
            let node = dq.insert(val: dataVal)
            map[kayVal] = node
        }
    }
}
