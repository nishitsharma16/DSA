//
//  LRUCache.swift
//  DSA
//
//  Created by Nishit on 15/06/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class DQNode<Key, ValType> {
    var next : DQNode?
    var prev : DQNode?
    let value : ValType
    let key : Key
    init(key: Key, val : ValType) {
        value = val
        self.key = key
    }
}

class DQList<Key, Val> {
    var front : DQNode<Key, Val>?
    var rear : DQNode<Key, Val>?
    let size : Int
    private var nodeCount = 0
    init(sizeVal : Int) {
        size = sizeVal
    }
    
    func sizeOfList() -> Int {
        return nodeCount
    }
    
    func getNode(key: Key, val : Val) -> DQNode<Key, Val> {
        return DQNode<Key, Val>(key:key, val: val)
    }
    
    func insert(key: Key, val : Val) -> (addedNode: DQNode<Key, Val>, removedKey: Key?) {
        let node = getNode(key: key, val: val)
        var removedKey: Key?
        if nodeCount < size {
            insertFromFront(node: node)
        }
        else {
            if let _ = rear {
                var temp = rear
                rear = temp?.prev
                removedKey = temp?.key
                temp = nil
                nodeCount -= 1
            }
            insertFromFront(node: node)
        }
        return (addedNode: node, removedKey: removedKey)
    }
    
    private func insertFromFront(node :  DQNode<Key, Val>) {
        if let _ = front {
            front?.prev = node
            node.next = front
        }
        else {
            rear = node
        }
        front = node
        nodeCount += 1
    }
}

//class DQLRUCache<Key : Hashable, Val> {
//    var map = [Key : DQNode<Val>]()
//    var dq : DQList<Val>
//    let cacheSize : Int
//    init(size : Int) {
//        cacheSize = size
//        dq = DQList(sizeVal: size)
//    }
//
//    func getNode(kayVal : Key) -> DQNode<Val>? {
//        if let node = map[kayVal] {
//            return node
//        }
//        return nil
//    }
//
//    func insertNode(kayVal : Key, dataVal : Val) {
//        if let _ = map[kayVal] {
//        }
//        else {
//            let node = dq.insert(val: dataVal)
//            map[kayVal] = node
//        }
//    }
//}

class Test {
    let x: String?
    init() {
        x = ""
    }
}
