//
//  LinkedList.swift
//  DSA
//
//  Created by Nishit on 11/06/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class ListNode<Value> {
    var item : Value
    var next : ListNode<Value>?
    init(value : Value) {
        item = value
    }
}

class NodeRandom<Value> {
    var item : Value
    var next : NodeRandom<Value>?
    var random : NodeRandom<Value>?
    init(value : Value) {
        item = value
    }
}

extension NodeRandom: Hashable where Value == Int {
    func hash(into hasher: inout Hasher) {
        hasher.combine(item)
    }
}

extension NodeRandom: Equatable where Value == Int {
    static func == (lhs: NodeRandom<Value>, rhs: NodeRandom<Value>) -> Bool {
        return lhs.item == rhs.item
    }
}

class LinkedList {
    
    var head: NodeRandom<Int>?
    init(head: NodeRandom<Int>?) {
        self.head = head
    }
    
    func cloneLinkedList() -> LinkedList {
        var curr: NodeRandom<Int>? = head
        var clone: NodeRandom<Int>?
        var map = [NodeRandom<Int>?: NodeRandom<Int>?]()
        
        while curr != nil {
            if let node = curr {
                clone = NodeRandom<Int>(value: node.item)
                map[curr] = clone
                curr = curr?.next
            }
        }
        
        curr = head
        
        while curr != nil {
            if let val = map[curr] {
                clone = val
                if let next = curr?.next, let val = map[next] {
                    clone?.next = val
                }
                if let random = curr?.random, let val = map[random] {
                    clone?.random = val
                }
                curr = curr?.next
            }
        }

        return LinkedList(head: head)
    }
}
