//
//  Stack.swift
//  DSA
//
//  Created by Nishit on 10/05/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class Stack<Item> {
    
    var list = [Item]()
    
    func push(val : Item) {
        list.append(val)
    }
    
    func pop() -> Item {
       return list.removeLast()
    }
    
    func top() -> Item? {
       return list.last
    }
}
