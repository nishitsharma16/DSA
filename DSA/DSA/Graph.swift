//
//  Graph.swift
//  DSA
//
//  Created by Nishit on 10/05/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class Node<Element : Hashable> {
    let value : Element
    init(x : Element) {
        value = x
    }
}

extension Node : Hashable {
    static func == (lhs: Node<Element>, rhs: Node<Element>) -> Bool {
        return lhs.value == rhs.value
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
    }
}

class Graph<ElementType : Hashable> {
    
    var nodeList : [[Node<ElementType>]] = []
    
    func insert(index : Int, node : Node<ElementType>) {
        nodeList[index].append(node)
    }
    
    // BFS means Level Order Traversal
    func bfs(node : Node<ElementType>) {
        
        var map : [Node<ElementType> : Bool] = [:]
        
        var queue = Queue<Node<ElementType>>()
        
        map[node] = true
        
        queue.enqueue(val: node)
        
        while !queue.isEmpty {
            
            let top = queue.dQueue()
            print("Value : \(top.value)")
            
            
        }
        
    }
    
    // DFS means Traversal like Inorder/Preorder/Postorder or stack traversal
    func dfs() {
        
    }
}

class GraphBuilder {
    
    func createGraph() {
        let graph = Graph<Int>()
        let root = Node<Int>(x: 2)
        let one = Node<Int>(x: 1)
        let zero = Node<Int>(x: 0)
        let three = Node<Int>(x: 3)
        graph.insert(index: 0, node: one)
        graph.insert(index: 0, node: root)
        graph.insert(index: 1, node: root)
        graph.insert(index: 2, node: zero)
        graph.insert(index: 2, node: three)
        graph.insert(index: 3, node: root)
        graph.bfs(node : root)
    }
}
