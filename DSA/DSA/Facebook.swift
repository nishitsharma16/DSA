//
//  Facebook.swift
//  DSA
//
//  Created by Nishit on 15/09/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

extension Problems {
    
    static func continuousSubArraySum(list: [Int], k: Int) -> Bool {
        if list.isEmpty {
            return false
        }
        
        if k == 0 && list.reduce(0, +) == 0  {
            return true
        }
        else if k == 0 {
            return false
        }
        
        let length = list.count
        var mat = Array(repeating: Array(repeating: 0, count: length), count: length)
        
        for i in 0..<length {
            mat[i][i] = list[i]
        }
        
        for l in 2...length {
            for i in 0..<length - l + 1 {
                let j = i + l - 1
                if (mat[i][j - 1] + list[j]) % k == 0 {
                    return true
                }
                else {
                    mat[i][j] = list[j] + mat[i][j - 1]
                }
            }
        }
        
        return false
    }
    
    static func cloneGraph(_ node: GrapthNode?) -> GrapthNode? {
        guard let root = node else { return nil }
        
        var map = [GrapthNode?: GrapthNode?]()
        let queue = Queue<GrapthNode>()
        queue.enqueue(val: root)
        
        let cloneRootNode = GrapthNode(root.val)
        map[root] = cloneRootNode
        
        while !queue.isEmpty {
            let front = queue.dQueue()
            if var list = front.neighbours {
                for item in list {
                    if let _ = map[item] {
                        
                    }
                    else {
                        let cloneNode = GrapthNode(root.val)
                        map[item] = cloneNode
                        queue.enqueue(val: item)
                    }
                    list.append(item)
                }
            }
        }
        return cloneRootNode
    }
    
    static func checkAnagram(_ str: String, _ map: [Character: Int]) -> Bool {
        var inner = map
        for item in str {
            if let _ = inner[item] {
                inner[item] = 0
            }
        }
        
        for item in inner {
            if item.value == 1 {
                return false
            }
        }
        return true
    }
    
    static func findAnagrams(_ s: String, _ p: String) -> [Int] {
        if s.isEmpty {
            return []
        }
        
        let slen = s.count
        let plen = p.count

        var map = [Character: Int]()
        for item in p {
            map[item] = 1
        }
        
        var result = [Int]()
        var start = s.startIndex
        for i in 0..<slen - plen + 1 {
            let end = s.index(start, offsetBy: plen - 1)
            let subStr = String(s[start...end])
            if checkAnagram(subStr, map) {
                result.append(i)
            }
            start = s.index(after: start)
        }
        
        return result
    }
    
    static func countSubarraySum(_ nums: [Int], _ k: Int) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        if nums.count == 1 {
            return nums[0] == k ? 1 : 0
        }
        
        let length = nums.count
        var mat = Array(repeating: Array(repeating: 0, count: length), count: length)
        var counter = 0
        
        for i in 0..<length {
            mat[i][i] = nums[i]
            if mat[i][i] == k {
                counter += 1
            }
        }
        
        for l in 2...length {
            for i in 0..<length - l + 1 {
                let j = i + l - 1
                if (mat[i][j - 1] + nums[j]) == k {
                    counter += 1
                }
                mat[i][j] = nums[j] + mat[i][j - 1]
            }
        }
        
        return counter
    }
}


class TrieNodeV2 {
    var list = Array<TrieNodeV2?>(repeating: nil, count:26)
    var isEndOfWord = false
}

class TrieSet2 {
    
    /** Initialize your data structure here. */
    private let root = TrieNodeV2()
    init() {
    }
    
    /** Adds a word into the data structure. */
    func addWord(_ word: String) {
        var curr: TrieNodeV2? = root
        for item in word {
            if item.isAlphabet, let val = item.asciiValue {
                let index = Int(val) - 97
                if curr?.list[index] == nil {
                    curr?.list[index] = TrieNodeV2()
                }
                curr = curr?.list[index]
            }
        }
        curr?.isEndOfWord = true
    }
    
    /** Returns if the word is in the data structure. A word could contain the dot character '.' to represent any one letter. */
    private func searchHelper(_ word: String, _ node: TrieNodeV2?) -> Bool {
        var curr: TrieNodeV2? = node
        for i in 0..<word.count {
            let item = word[i]
            if item.isAlphabet, let val = item.asciiValue {
                let index = Int(val) - 97
                if curr?.list[index] == nil {
                    return false
                }
                curr = curr?.list[index]
            }
            else {
                if item == "." {
                    if let currList = curr?.list {
                        for item in currList {
                            if item != nil {
                                let node = item
                                let nextIndex = word.index(word.startIndex, offsetBy: i + 1)
                                let suffix = word.suffix(from: nextIndex)
                                if searchHelper(String(suffix), node) {
                                    return true
                                }
                            }
                        }
                    }
                }
            }
        }
        return curr != nil && curr?.isEndOfWord == true
    }
    
    func search(_ word: String) -> Bool {
        return searchHelper(word, root)
    }
}

class GrapthNode {
    let val: Int
    var neighbours: [GrapthNode]?
    init(_ val: Int) {
        self.val = val
    }
}

extension GrapthNode: Hashable {
    static func == (lhs: GrapthNode, rhs: GrapthNode) -> Bool {
        return lhs.val == rhs.val
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(val)
    }
}
