//
//  Microsoft.swift
//  DSA
//
//  Created by Nishit on 14/12/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

extension Problems {

    static func findDuplicates(_ nums: [Int]) -> [Int] {
        if nums.isEmpty {
            return []
        }
        var result = [Int]()
        var map = [Int: Int]()
        for item in nums {
            if let val = map[item] {
                if val == 1 {
                    result.append(item)
                }
                map[item] = val + 1
            }
            else {
                map[item] = 1
            }
        }
        return result
    }
    
    func inorderSuccessorV2(_ node: TreeParentNode?) -> TreeParentNode? {
        if node == nil {
            return nil
        }
        var curr: TreeParentNode?
        if node?.right != nil {
            curr = node?.right
            while curr?.left != nil {
                curr = curr?.left
            }
            return curr
        }
        else {
            curr = node
            var parent = curr?.parent
            while parent != nil && parent?.left != curr {
                curr = curr?.parent
                parent = curr?.parent
            }
            return parent
        }
    }
    
    func reverseString(_ s: inout [Character]) {
        var l = 0
        var r = s.count - 1
        while l < r {
            s.swapAt(l, r)
            l += 1
            r -= 1
        }
    }
    
    static func myAtoi(_ str: String) -> Int {
        let val = str.trimmingCharacters(in: .whitespacesAndNewlines)
        if val.isEmpty {
            return 0
        }
        var str = Array(val)
        let isPositive = str[0] != "-"
        if str[0] == "-" || str[0] == "+" {
            str.removeFirst()
        }
        if str.isEmpty {
            return 0
        }
        if !str[0].isNumber {
            return 0
        }
        
        var result = 0
        for item in str {
            if item.isNumber {
                let x = String(item)
                result = 10*result + (Int(x) ?? 0)
                if result > Int32.max {
                    return isPositive ? Int(Int32.max) : Int(Int32.min)
                }
            }
            else {
                break
            }
        }
        
        return isPositive ? result : -result
    }
    
    enum IPType: String {
        case Neither
        case IPv4
        case IPv6
    }
    
    func validateIPComponent(_ val: String, _ ipType: IPType) -> Bool {
        let len = val.count
        if ipType == .IPv4 {
            if len >= 1 && len <= 3 && val[0] != "0" {
                if let x = Int(val), x >= 0 && x <= 255 {
                    return true
                }
            }
        }
        else if ipType == .IPv6 {
            if len >= 1 && len <= 4 {
                return val.isHexaDecimal()
            }
        }
        return false
    }
    
    func validIPAddress(_ IP: String) -> String {
        if IP.isEmpty {
            return IPType.Neither.rawValue
        }
        var components = [String]()
        var ipType: IPType = .Neither
        if let _ = IP.firstIndex(of: ".") {
            components = IP.components(separatedBy: ".")
            ipType = components.count == 4 ? .IPv4 : .Neither
        }
        else if let _ = IP.firstIndex(of: ":") {
            components = IP.components(separatedBy: ":")
            ipType = components.count == 8 ? .IPv6 : .Neither
        }
        
        for item in components {
            if !validateIPComponent(item, ipType) {
                return IPType.Neither.rawValue
            }
        }
        
        return ipType.rawValue
    }
    
    func reverseWord(_ s: inout [Character], _ start: Int, _ end: Int) {
        var l = start
        var r = end
        
        while l < r {
            s.swapAt(l, r)
            l += 1
            r -= 1
        }
    }
    
    func reverseWords(_ s: String) -> String {
        if s.isEmpty {
            return ""
        }
        
        var list = s.map { $0 }
        var start = 0
        let len = s.count
        for i in 0..<len {
            if list[i] == " " {
                reverseWord(&list, start, i - 1)
                start = i + 1
            }
        }
        reverseWord(&list, start, len - 1)
        let result = list.reduce("", { (prev, curr) -> String in
            prev + String(curr)
        })
        return result
    }
    
    func reverseWordsV2(_ s: String) -> String {
        if s.isEmpty {
            return ""
        }
        
        var result = ""
        let list = s.split(separator: " ")
        for item in list {
            result += String(item.reversed()) + " "
        }
        
        result.remove(at: result.index(before: result.endIndex))
        return result
    }
    
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        let left = invertTree(root?.left)
        let rigt = invertTree(root?.right)
        root?.left = rigt
        root?.right = left
        return root
    }
    
    func singleNumber(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        let sum = nums.reduce(0, +)
        let set = Set<Int>(nums)
        let setSum = set.reduce(0, +)
        return 2*setSum - sum
    }
    
    func deleteNode(_ node: SortedNode?) {
        if node == nil {
            return
        }
        
        var curr = node
        if curr?.next != nil, let nextVal = curr?.next?.val {
            curr?.val = nextVal
            var temp = curr?.next
            curr?.next = temp?.next
            temp = nil
        }
        else {
            curr = nil
        }
    }
    
    func fizzBuzz(_ n: Int) -> [String] {
        if n < 1 {
            return []
        }
        
        var result = [String]()
        for i in 1...n {
            if i % 3 == 0 {
                result.append("Fizz")
            }
            else if i % 5 == 0 {
                result.append("Buzz")
            }
            else if i % 15 == 0 {
                result.append("FizzBuzz")
            }
            else {
                result.append("\(i)")
            }
        }
        return result
    }
    
    func inOrder(_ root: TreeNode?, _ list: inout [Int]) {
        if let r = root {
            inOrder(r.left, &list)
            list.append(r.value)
            inOrder(r.right, &list)
        }
    }
    
    func makeTree(_ list: [Int], _ low: Int, _ high: Int) -> TreeNode? {
        if low > high {
            return nil
        }
        
        let mid = (low + high)/2
        let root = TreeNode(val: list[mid])
        let left = makeTree(list, low, mid - 1)
        root.left = left
        root.right = makeTree(list, mid + 1, high)
        return root
    }
    
    func trimBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        if let val = root?.value {
            if val > high {
                return trimBST(root?.left, low, high)
            }
            else if val < low {
                return trimBST(root?.right, low, high)
            }
        }
        root?.left = trimBST(root?.left, low, high)
        root?.right = trimBST(root?.right, low, high)
        return root
    }
    
    static func canPermutePalindrome(_ s: String) -> Bool {
        var map = [Character: Int]()
        for item in s {
            if let val = map[item] {
                map[item] = val + 1
            }
            else {
                map[item] = 1
            }
        }
        var x = 0
        for item in map {
            x += item.value % 2
        }
        return x <= 1
    }
    
    static func reverseInt(_ x: Int) -> Int {
        var result = 0
        let isNegative = x < 0
        var n = x >= 0 ? x : -x
        while n > 0 {
            result = result * 10 + (n % 10)
            n /= 10
        }
        if result > Int32.max {
            return 0
        }
        return isNegative ? -result : result
    }
    
    func countPrimes(_ n: Int) -> Int {
        if n < 2 {
            return 0
        }
        var counter = 0
        var status = Array(repeating: false, count: n)
        for i in 2..<n {
            if !status[i] {
                counter += 1
                var j = 0
                while i*j < n {
                    status[i*j] = true
                    j += 1
                }
            }
        }
        return counter
    }
    
    func checkPalindrome(_ s: ArraySlice<Character>, _ start: Int, _ end: Int) -> Bool {
        var l = start
        var r = end
        while l < r {
            if s[l] != s[r] {
                return false
            }
            l += 1
            r -= 1
        }
        return true
    }
    
    func validPalindrome2(_ s: String) -> Bool {
        let str = Array(s)[0...]
        var start = 0
        var end = s.count - 1
        while start < end {
            if str[start] != str[end] {
                return checkPalindrome(str, start + 1, end) || checkPalindrome(str, start, end - 1)
            }
            start += 1
            end -= 1
        }
        return true
    }
    
    static func isPalindromeSentence(_ s: String) -> Bool {
        let str = Array(s)[0...]
        if str.isEmpty {
            return true
        }
        var l = 0
        var r = str.count - 1
        while l <= r {
            if !str[l].isValidAlphabet {
                l += 1
            }
            else if !str[r].isValidAlphabet {
                r -= 1
            }
            else if str[l].lowercased() == str[r].lowercased() {
                l += 1
                r -= 1
            }
            else {
                return false
            }
        }
        return true
    }
    
    static func compareVersionHelper(_ v1: [String], _ v2: [String], _ shouldToggle: Bool) -> Int {
        
        if v1.count > v2.count {
            return compareVersionHelper(v2, v1, true)
        }
        var counter = 0
        var i = 0
        while i < v1.count {
            let item1 = myAtoi(v1[i])
            let item2 = myAtoi(v2[i])
            if item1 > item2 {
                return shouldToggle ?  -1 : 1
            }
            else if item1 < item2 {
                return shouldToggle ?  1 : -1
            }
            i += 1
            counter += 1
        }
        while counter < v2.count {
            let item1 = myAtoi(v2[counter])
            if item1 > 0 {
                return shouldToggle ?  1 : -1
            }
            counter += 1
        }
        return 0
    }
    
    static func compareVersion(_ version1: String, _ version2: String) -> Int {
        let val1 = version1.components(separatedBy: ".")
        let val2 = version2.components(separatedBy: ".")
        let result = compareVersionHelper(val1, val2, false)
        return result
    }
    
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ k: Int, _ t: Int) -> Bool {
        if k < 1 {
            return false
        }
        
        return false
    }
}

class ArrayReader {
    public func get(_ index: Int) -> Int {
        return -1
    }
}



class ArrayReaderItemSearch {
    
    static func binarySearchWith(_ reader: ArrayReader, _ low: Int, _ high: Int, _ target: Int) -> Int {
        if low > high {
            return -1
        }
        let mid = (low + high)/2
        if reader.get(mid) == target {
            return mid
        }
        else if reader.get(mid) > target {
            return binarySearchWith(reader, mid + 1, high, target)
        }
        else {
            return binarySearchWith(reader, low, mid - 1, target)
        }
    }
    
    static func search(_ reader: ArrayReader, _ target: Int) -> Int {
        var low = 0
        var high = 1
        if reader.get(low) > target {
            return -1
        }
        while target > reader.get(high) {
            low = high
            high = 2*high
        }
        while low <= high {
            let mid = (low + high)/2
            let val = reader.get(mid)
            if val == target {
                return mid
            }
            else if val < target {
                low = mid + 1
            }
            else {
                high = mid - 1
            }
        }
        return -1
    }
}

class ShuffleSolution {

    private func shuffleList() -> [Int] {
        let length = list.count
        for i in 0..<length {
            let randIndex = Int.random(in: i..<length)
            list.swapAt(i, randIndex)
        }
        return list
    }
    
    private var original: [Int]
    private var list: [Int]
    init(_ nums: [Int]) {
        list = nums
        original = nums
    }
    
    /** Resets the array to its original configuration and return it. */
    func reset() -> [Int] {
        list = original
        return list
    }
    
    /** Returns a random shuffling of the array. */
    func shuffle() -> [Int] {
        return shuffleList()
    }
}

class MovingAverage {

    /** Initialize your data structure here. */
    private var list = [Int]()
    private var size: Int
    private var sum: Int = 0
    init(_ size: Int) {
        self.size = size
    }
    
    func next(_ val: Int) -> Double {
        if list.count < size {
            list.append(val)
            sum += val
        }
        else {
            let item = list.removeFirst()
            sum -= item
            list.append(val)
            sum += val
        }
        return Double(sum) / Double(list.count)
    }
}


extension Character {
    var isValidAlphabet: Bool {
        if let val = self.unicodeScalars.first, CharacterSet.alphanumerics.contains(val) {
            return true
        }
        return false
    }
}
