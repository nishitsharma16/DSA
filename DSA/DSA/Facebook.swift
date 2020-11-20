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
    
    func cloneGraph(_ node: GrapthNode?) -> GrapthNode? {
            guard let root = node else { return nil }
            
            var map = [GrapthNode: GrapthNode]()
            let queue = Queue<GrapthNode>()
            queue.enqueue(val: root)
            
            let cloneRootNode = GrapthNode(root.val)
            map[root] = cloneRootNode
            
            while !queue.isEmpty {
                let front = queue.dQueue()
                let list = front.neighbours
                for item in list {
                    if let _ = map[item] {
                        
                    }
                    else {
                        let cloneNode = GrapthNode(item.val)
                        map[item] = cloneNode
                        queue.enqueue(val: item)
                    }
                    if let frontMapClone = map[front], let newCloneNode = map[item] {
                        frontMapClone.neighbours.append(newCloneNode)
                    }
                }
            }
            return cloneRootNode
        }
    
//    static func checkAnagram(_ str: String, _ map: [Character: Int]) -> Bool {
//        var inner = map
//        for item in str {
//            if let _ = inner[item] {
//                inner[item] = 0
//            }
//        }
//        
//        for item in inner {
//            if item.value == 1 {
//                return false
//            }
//        }
//        return true
//    }
//    
//    static func findAnagrams(_ s: String, _ p: String) -> [Int] {
//        if s.isEmpty {
//            return []
//        }
//        
//        let slen = s.count
//        let plen = p.count
//
//        var map = [Character: Int]()
//        for item in p {
//            map[item] = 1
//        }
//        
//        var result = [Int]()
//        var start = s.startIndex
//        for i in 0..<slen - plen + 1 {
//            let end = s.index(start, offsetBy: plen - 1)
//            let subStr = String(s[start...end])
//            if checkAnagram(subStr, map) {
//                result.append(i)
//            }
//            start = s.index(after: start)
//        }
//        
//        return result
//    }
    
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
    
    static func reverseWords(_ s: String) -> String {
        if s.isEmpty {
            return ""
        }
        
        let str = s.trimmingCharacters(in: .whitespacesAndNewlines)
        var result = ""
        let words = str.split { $0 == " " }
        let numberOfSpaes = words.count - 1
        let last = numberOfSpaes
        for i in stride(from: last, through: 1, by: -1) {
            result += words[i]
            result += " "
        }
        result += words[0]
        return result
    }
    
    static func fractionToDecimal(_ numerator: Int, _ denominator: Int) -> String {
        if numerator == 0 || denominator == 0 {
            return "0"
        }
        
        if numerator == 0 || denominator == 0 {
            return "0"
        }
        
        let isResultNegative = numerator < 0 || denominator < 0
        let num = abs(numerator)
        let deno = abs(denominator)
        var fraction = "\(num / deno)"
        var remainder = num % deno
        if remainder == 0 {
            return fraction
        }
        else {
            var map = [Int: Int]()
            fraction += "."
            while remainder != 0 {
                if let length = map[remainder] {
                    fraction.insert("(", at: fraction.index(fraction.startIndex, offsetBy: length))
                    fraction += ")"
                    break
                }
                map[remainder] = fraction.count
                remainder *= 10
                fraction += "\(remainder / deno)"
                remainder = remainder % deno
            }
            return isResultNegative ? "-" + fraction : fraction
        }
    }
    
    static func zeroPosition(_ s: String) -> Int? {
        for index in 0..<s.count {
            if s[index] == "0" {
                return index
            }
        }
        return nil
    }
    
    static func numDecodings(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        
        let length = s.count
        var result = 0
        let zeroPos = zeroPosition(s)
        if length == 1 {
            if let _ = zeroPos {
                return 0
            }
            else {
                return 1
            }
        }
        else if length == 2 {
            if let val = zeroPos {
                if val == 0 {
                    return 0
                }
                else {
                    if let x = Int(s), x < 26 {
                        return 1
                    }
                }
            }
            else {
                result += 1
                if let x = Int(s), x <= 26 {
                    return result + 1
                }
                return result
            }
        }
        else {
            if let val = zeroPos {
                if val == 0 {
                    return 0
                }
                else {
                    
                }
            }
        }
        return result
    }
    
    private static func decodeWaysHelper(_ s: String, _ index: Int, map: inout [Int : Int]) -> Int {
        
        if index < s.count && s[index] == "0" {
            return 0
        }
        
        if index == s.count - 1 {
            return 1
        }
        
        if index == s.count {
            return 1
        }
        
        if let x = map[index] {
            return x
        }
        
        var result = decodeWaysHelper(s, index + 1, map: &map)
        
        if let y = Int(String(s[s.index(s.startIndex, offsetBy: index)..<s.index(s.startIndex, offsetBy: index + 2)])), y <= 26 {
            result += decodeWaysHelper(s, index + 2, map: &map)
        }
        
        map[index] = result
        
        return result
    }
    
    static func decodeWays(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        
        var map = [Int: Int]()
        let x = decodeWaysHelper(s, 0, map: &map)
        return x
    }
    
    static func kDiffPairs(_ nums: [Int], _ k: Int) -> Int {
        if nums.isEmpty || nums.count == 1 {
            return 0
        }
        
        var map = [Int: Int]()
        for item in nums {
            if let x = map[item] {
                map[item] = x + 1
            }
            else {
                map[item] = 1
            }
        }
        var counter = 0
        
        for item in map.enumerated() {
            let key = item.element.key
            let val = item.element.value
            if k > 0 , let _ = map[key + k] {
                counter += 1
            }
            else if k == 0 && val > 1 {
                counter += 1
            }
        }
        
        return counter
    }
    
    static func missingRanges(_ nums: [Int], _ lower: Int, _ upper: Int) -> [String] {
        var result = [String]()
        var val = ""
        if nums.isEmpty {
            if lower == upper {
                val = "\(lower)"
            }
            else {
                val = "\(lower)->\(upper)"
            }
            if !val.isEmpty {
                result.append(val)
            }
        }
        else {
            if nums.count == 1 {
                if let y = nums.first, lower == upper, lower == y {
                    return []
                }
                else if let y = nums.first, lower < upper, upper == y {
                    return ["\(lower)"]
                }
                else if let y = nums.first, lower < upper, lower == y {
                    return ["\(upper)"]
                }
                else {
                    return ["\(lower)->\(upper)"]
                }
            }
            else {
                if let y = nums.first, lower < y {
                    if y == lower + 2 {
                        val = "\(lower)->\(y - 1)"
                    }
                    else if lower + 2 < y {
                        val = "\(lower)->\(y - 1)"
                    }
                    if !val.isEmpty {
                        result.append(val)
                    }
                }
                for index in 0..<nums.count - 1 {
                    let curr = nums[index]
                    let next = nums[index + 1]
                    if curr == next - 2 {
                        val = "\(curr + 1)"
                    }
                    else if curr + 2 < next {
                        val = "\(curr + 1)->\(next - 1)"
                    }
                    if !val.isEmpty {
                        result.append(val)
                    }
                }
                if let y = nums.last, y < upper {
                    if y == upper - 2 {
                        val = "\(y + 1)"
                    }
                    else if y + 2 < upper {
                        val = "\(y + 1)->\(upper)"
                    }
                    if !val.isEmpty {
                        result.append(val)
                    }
                }
                return result
            }
        }
        return result
    }
    
    func validateBST(_ root: TreeNode?, min: Int, max: Int) -> Bool {
        if let rootVal = root {
            if rootVal.value >= max {
                return false
            }
            if rootVal.value <= min {
                return false
            }
            return validateBST(rootVal.left, min: min, max: rootVal.value - 1) && validateBST(rootVal.right, min: rootVal.value + 1, max: max)
        }
        return true
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        return validateBST(root, min: Int.min, max: Int.max)
    }
    
    static func removeKdigits(_ num: String, _ k: Int) -> String {
        if num.isEmpty {
            return ""
        }
        
        if k == 0 {
            return num
        }
        
        var str = num
        var counter = 0
        var start = str.index(after: str.startIndex)
        while start < str.endIndex && counter < k {
            let prevIndex = str.index(before: start)
            if str[prevIndex] >= str[start] {
                str.remove(at: prevIndex)
                counter += 1
            }
            else {
                start = str.index(after: start)
            }
        }
        
        while counter < k {
            str.removeLast()
            counter += 1
        }
        
        start = str.startIndex
        while start < str.endIndex {
            if str[start] == "0" {
                str.remove(at: start)
            }
            else {
                break
            }
        }
        return str.isEmpty ? "0" : str
    }

    static func dfsSolve(_ board: inout [[Character]], _ x: Int, _ y: Int, _ state: inout [[(visited: Bool, flip: Int)]], _ m : Int, _ n: Int) {
        var item = state[x][y]
        item.visited = true
        item.flip = 0
        state[x][y] = item

        let dir = [(1, 0), (-1, 0), (0, -1), (0, 1)]
        for item in dir {
            let i = x + item.0
            let j = y + item.1
            if i >= 0 && j >= 0 && i < m && j < n {
                let val = state[i][j]
                if !val.visited && board[i][j] == "O" {
                    dfsSolve(&board, i, j, &state, m, n)
                }
            }
        }
    }
    
    static func solve(_ board: inout [[Character]]) {
        if board.isEmpty {
            return
        }
        
        let m = board.count
        let n = board[0].count
        var state = Array(repeating: Array(repeating: (visited: false, flip: 1), count: board[0].count), count: board.count)

        for i in 0..<m {
            for j in 0..<n {
                if (i == 0 || j == 0 || i == m - 1 || j == n - 1) && board[i][j] == "O" {
                    let item = state[i][j]
                    if !item.visited {
                        dfsSolve(&board, i, j, &state, m, n)
                    }
                }
            }
        }
        
        for i in 0..<m {
            for j in 0..<n {
                let item = state[i][j]
                if board[i][j] == "O" && item.flip == 1 {
                    board[i][j] = "X"
                }
            }
        }
    }
    
    static func largestNumber(_ nums: [Int]) -> String {
        if nums.isEmpty {
            return ""
        }
        
        let x = nums.reduce(0, +)
        if x == 0 {
            return "0"
        }
        
        let val = nums.sorted { (first, second) -> Bool in
            let x = "\(first)\(second)"
            let y = "\(second)\(first)"
            return x > y
        }
        
        let result = val.reduce("") { (result, curr) -> String in
            return result + "\(curr)"
        }
        return result
    }
    
    static func wiggleSort(_ nums: inout [Int]) {
        if nums.isEmpty {
            return
        }
        
        let length = nums.count
        let val = nums.sorted { $0 > $1 }
        var mid = length / 2
        
        var j = 0
        for i in 0..<length {
            if i % 2 == 0 {
                nums[i] = val[mid]
                mid += 1
            }
            else {
                nums[i] = val[j]
                j += 1
            }
        }
    }
    
    static func checkValidParenthesisString(_ s: String) -> Bool {
        if s.isEmpty {
            return true
        }
        
        let list = s.map { String($0) }
        var low = 0
        var high = 0
        
        for item in list {
            low += item == "(" ? 1 : -1
            high += item != ")" ? 1 : -1
            if high < 0 {
                break
            }
            low = max(low, 0)
        }
        
        return low == 0
    }
    
    static func nextGreaterNumber3(_ n: Int) -> Int {
        if n < 10 {
            return -1
        }
        
        var list = [Int]()
        var number = n
        while number > 0 {
            list.append(number % 10)
            number /= 10
        }
        
        list.reverse()
        let length = list.count
        var i = length - 2
        while i >= 0 && list[i + 1] <= list[i] {
            i -= 1
        }
        
        if i == -1 {
            return -1
        }
        
        var j = length - 1
        while j >= 0 && list[i] >= list[j] {
            j -= 1
        }
        
        list.swapAt(i, j)
        list.reverseArray(start: i + 1, end: length - 1)
        
        i = 0
        var result = 0
        for item in list {
            result = result * 10 + item
        }
        
        return result == 0 ? -1 : result
    }
    
    static func insert(_ head: SortedNode?, _ insertVal: Int) -> SortedNode? {
        if let _ = head {
            var curr: SortedNode? = head
            var temp: SortedNode?
            while curr != nil {
                if let currval = curr, let next = currval.next, insertVal >= currval.val && insertVal < next.val {
                    let insert = SortedNode(insertVal)
                    temp = currval.next
                    currval.next = insert
                    insert.next = temp
                    break
                }
                curr = curr?.next
            }
            return head
        }
        let headval = SortedNode(insertVal)
        headval.next = headval
        return headval
    }
    
    static func findNthDigit(_ n: Int) -> Int {
        if n <= 0 {
            return -1
        }
        
        var nVal = n
        var rangeVal = 9
        var length = 1
        while nVal - (rangeVal * length) > 0 {
            nVal -= rangeVal * length
            length += 1
            rangeVal *= 10
        }
        
        let digitVal = (nVal - 1) / length
        let digitPos = (nVal - 1) % length
        let number = "\((rangeVal / 9) + digitVal)"
        let digit = String(number[digitPos])
        return Int(digit) ?? -1
    }
    
    static func isOneEditDistance(_ s: String, _ t: String) -> Bool {
        let sLen = s.count
        let tLen = t.count
        
        if sLen > tLen {
            return isOneEditDistance(t, s)
        }
        
        if tLen - sLen > 1 {
            return false
        }
            
        var foundForEqualLength = false
        var foundForDiffLength = false
        var index = 0
        
        for i in 0..<s.count {
            if s[i] != t[i] {
                if sLen == tLen {
                    foundForEqualLength = true
                    index = i
                    break
                }
                else {
                    foundForDiffLength = true
                    index = i
                    break
                }
            }
        }
        
        if foundForEqualLength {
            let index = s.index(s.startIndex, offsetBy: index + 1)
            return s[index..<s.endIndex] == t[index..<t.endIndex]
        }
        else if foundForDiffLength {
            let indexS = s.index(s.startIndex, offsetBy: index)
            let indexT = s.index(s.startIndex, offsetBy: index + 1)
            return s[indexS..<s.endIndex] == t[indexT..<t.endIndex]
        }
        return sLen + 1 == tLen
    }
    
    
    static func lps(pat : String) -> [Int] {
        if pat.isEmpty {
            return []
        }
        let strLen = pat.count
        var lps = Array<Int>(repeating: 0, count: strLen)
        var length = 0
        lps[0] = 0
        var index = 1
        while index < strLen {
            if pat[index] == pat[length] {
                length += 1
                lps[index] = length
                index += 1
            }
            else {
                if length != 0 {
                    length = lps[length - 1]
                }
                else {
                    if length == 0 {
                        lps[index] = 0
                        index += 1
                    }
                }
            }
        }
        return lps
    }
    
    static func kmpAlgorithmForFirstIndex(str : String, pat : String) -> Int {
        if str.isEmpty || pat.isEmpty {
            return -1
        }
        
        let strLength = str.count
        let patLength = pat.count
        
        if patLength > strLength {
            return -1
        }
        
        let lpsVal = lps(pat: pat)
        
        var i = 0
        var j = 0
        
        while i < strLength {
            if str[i] == pat[j] {
                i += 1
                j += 1
            }
            
            if j == patLength {
                return i - j
            }
            else if i < strLength && pat[j] != str[i] {
                if j > 0 {
                    j = lpsVal[j - 1]
                }
                else {
                    i += 1
                }
            }
        }
        return -1
    }
    
    static func repeatedStringMatch(_ a: String, _ b: String) -> Int {
        var str = a
        var counter = 1
        while str.count < b.count {
            str += a
            counter += 1
        }
        
        if kmpAlgorithmForFirstIndex(str: str, pat: b) != -1 {
            return counter
        }
        str += a
        if kmpAlgorithmForFirstIndex(str: str, pat: b) != -1 {
            return counter + 1
        }
        
        return -1
    }
    
    static func nextPermutation(_ nums: inout [Int]) {
        if nums.isEmpty {
            return
        }
        
        let length = nums.count
        var i = length - 2
        while i >= 0 && nums[i + 1] <= nums[i] {
            i -= 1
        }
        
        if i == -1 {
            nums.sort()
            return
        }
        
        var j = length - 1
        while j >= 0 && nums[i] >= nums[j] {
            j -= 1
        }
        
        nums.swapAt(i, j)
        nums.reverseArray(start: i + 1, end: length - 1)
    }
    
    
    static func getPivotPosition(_ nums: [Int], _ l: Int, _ r: Int, _ length: Int) -> Int {
        if l > r {
            return -1
        }
        let mid = (l + r) / 2
        if l == r {
            return mid
        }
        else if mid - 1 >= 0 && mid + 1 < length && nums[mid] < nums[mid - 1] && nums[mid] >= nums[mid + 1] {
            return mid
        }
        else if mid - 1 >= 0 && nums[mid] <= nums[mid - 1] {
            return getPivotPosition(nums, l, mid - 1, length)
        }
        else {
            return getPivotPosition(nums, mid + 1, r, length)
        }
    }
    
    static func searchInSortedPart(_ nums: [Int], start: Int, end: Int, _ target: Int) -> Bool {
        if start > end {
            return false
        }
        
        let mid = (start + end) / 2
        if nums[mid] == target {
            return true
        }
        else if target < nums[mid] {
            return searchInSortedPart(nums, start: start, end: mid - 1, target)
        }
        else {
            return searchInSortedPart(nums, start: mid + 1, end: end, target)
        }
    }
    
    static func searchHelper(_ nums: [Int], _ target: Int, _ l: Int, _ r: Int) -> Bool {
        if l > r {
            return false
        }
        
        let mid = (l + r) / 2
        if nums[mid] == target {
            return true
        }
        
        let leftSorted = nums[l] <= nums[mid]
        let righSorted = nums[mid] <= nums[r]
        
        if leftSorted && righSorted {
            return searchHelper(nums, target, l, mid - 1) || searchHelper(nums, target, mid + 1, r)
        }
        else if righSorted {
            if target > nums[mid] && target <= nums[r] {
                return searchHelper(nums, target, mid + 1, r)
            }
            else {
                return searchHelper(nums, target, l, mid - 1)
            }
        }
        else if leftSorted {
            if target >= nums[l] && target < nums[mid] {
                return searchHelper(nums, target, l, mid - 1)
            }
            else {
                return searchHelper(nums, target, mid + 1, r)
            }
        }
        return false
    }
    
    static func search(_ nums: [Int], _ target: Int) -> Bool {
        if nums.isEmpty {
            return false
        }
        
        let length = nums.count
        return searchHelper(nums, target, 0, length - 1)
    }
    
    static func searchForIndexHelper(_ nums: [Int], _ target: Int, _ l: Int, _ r: Int) -> Int {
        if l > r {
            return -1
        }
        
        let mid = (l + r) / 2
        if nums[mid] == target {
            return mid
        }
        
        let leftSorted = nums[l] <= nums[mid]
        let righSorted = nums[mid] <= nums[r]
        
        if righSorted {
            if target > nums[mid] && target <= nums[r] {
                return searchForIndexHelper(nums, target, mid + 1, r)
            }
            else {
                return searchForIndexHelper(nums, target, l, mid - 1)
            }
        }
        else if leftSorted {
            if target >= nums[l] && target < nums[mid] {
                return searchForIndexHelper(nums, target, l, mid - 1)
            }
            else {
                return searchForIndexHelper(nums, target, mid + 1, r)
            }
        }
        return -1
    }
    
    static func searchForIndex(_ nums: [Int], _ target: Int) -> Int {
        if nums.isEmpty {
            return -1
        }
        
        let length = nums.count
        return searchForIndexHelper(nums, target, 0, length - 1)
    }
    
    static func simplifyPath(_ path: String) -> String {
        if path.isEmpty {
            return ""
        }
        
        let list = path.split(separator: "/", maxSplits: Int.max, omittingEmptySubsequences: true)
        let stack = Stack<String>()
        
        for item in list {
            if item == ".." {
                if !stack.isEmpty {
                    stack.pop()
                }
            }
            else if item != "." {
                stack.push(val: String(item))
            }
        }
        
        var result = ""
        while !stack.isEmpty {
            result = "/" + stack.pop() + result
        }
        
        return result.isEmpty ? "/" : result
    }
    
    static func multiplyHelper(_ num1: String, _ num2: String) -> String {
        guard let x = Int(num2) else { return "" }
        if x == 0 {
            return "0"
        }
        else if x == 1 {
            return num1
        }
        
        var result = ""
        var div = 0
        for item in num1 {
            if let y = Int(String(item)) {
                let m = y * x + div
                let rem = m % 10
                div = m / 10
                result = "\(rem)" + result
            }
        }
        
        if div != 0 {
            result = "\(div)" + result
        }
        return result
    }
    
    static func multiply(_ num1: String, _ num2: String) -> String {
        if num1.isEmpty || num2.isEmpty {
            return ""
        }
        
        var multiplier = 1
        for item in num2 {
            
        }
        
        return ""
    }
    
    static func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        if intervals.isEmpty {
            return [newInterval]
        }
        
        let length = intervals.count
        var result = [[Int]]()
        var index = 0
        let newIntervalStart = newInterval[0]
        let newIntervalEnd = newInterval[1]
        while index < length && newIntervalStart > intervals[index][0] {
            result.append(intervals[index])
            index += 1
        }
        
        var interval: [Int]
        if result.isEmpty {
            result.append(newInterval)
        }
        else if let last = result.last, last[1] < newIntervalStart {
            result.append(newInterval)
        }
        else {
            interval = result.removeLast()
            interval[1] = max(newIntervalEnd, interval[1])
            result.append(interval)
        }
        
        while index < length {
            interval = intervals[index]
            let start = interval[0]
            let end = interval[1]
            if let last = result.last, last[1] < start {
                result.append(interval)
            }
            else {
                interval = result.removeLast()
                interval[1] = max(end, interval[1])
                result.append(interval)
            }
            index += 1
        }
        
        return result
    }
    
    static func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        if matrix.isEmpty {
            return []
        }
        
        var result = [Int]()
        let m = matrix.count
        let n = matrix[0].count
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        let dir = [(0,1), (1,0), (0,-1), (-1,0)]
        var x = 0
        var y = 0
        var dirPos = 0
        var currDir: (Int, Int)
        for _ in 0..<m*n {
            result.append(matrix[x][y])
            currDir = dir[dirPos]
            visited[x][y] = true
            let row = x + currDir.0
            let col = y + currDir.1
            if row >= 0 && row < m && col >= 0 && col < n && !visited[row][col] {
                x = row
                y = col
            }
            else {
                dirPos = (dirPos + 1) % 4
                currDir = dir[dirPos]
                x += currDir.0
                y += currDir.1
            }
        }
        return result
    }
    
    static func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        if obstacleGrid.isEmpty {
            return 0
        }
        
        if obstacleGrid[0][0] == 1 {
            return 0
        }
        
        let m = obstacleGrid.count
        let n = obstacleGrid[0].count
        
        var list = obstacleGrid
        list[0][0] = 1
        
        for j in 1..<n {
            list[0][j] = list[0][j] == 0 && list[0][j - 1] == 1 ? 1 : 0
        }
        
        for i in 1..<m {
            list[i][0] = list[i][0] == 0 && list[i - 1][0] == 1 ? 1 : 0
        }
        
        for i in 1..<m {
            for j in 1..<n {
                if list[i][j] == 0 {
                    list[i][j] = list[i - 1][j] + list[i][j - 1]
                }
                else {
                    list[i][j] = 0
                }
            }
        }
        return list[m - 1][n - 1]
    }
    
    func canJump(_ nums: [Int]) -> Bool {
        if nums.isEmpty {
            return false
        }
        
        var last = nums.count - 1
        var counter = last
        while counter >= 0 {
            if counter + nums[counter] >= last {
                last = counter
            }
            counter -= 1
        }
        return last == 0
    }
    
    static func findItineraryHelperDFS(_ origin: String, _ ticketsMap: inout [String: [String]], _ result: inout [String]) {
        if var val = ticketsMap[origin] {
            for _ in val {
                let dst = val.removeFirst()
                ticketsMap[origin] = val
                findItineraryHelperDFS(dst, &ticketsMap, &result)
            }
        }
        if result.isEmpty {
            result.append(origin)
        }
        else {
            result.insert(origin, at: 0)
        }
    }
    
    static func findItineraryV2(_ tickets: [[String]]) -> [String] {
        if tickets.isEmpty {
            return []
        }
        
        var map = [String: [String]]()
        for item in tickets {
            let source = item[0]
            let dst = item[1]
            if var val = map[source] {
                val.append(dst)
                map[source] = val
            }
            else {
                map[source] = [dst]
            }
        }
        
        map.forEach { (key, val) in
            map[key] = val.sorted()
        }
        var result = [String]()
        findItineraryHelperDFS("JFK", &map, &result)
        return result
    }
    
    static func basicCalculater2(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        
        var lastVal = 0
        var currVal = 0
        var result = 0
        var operatorVal = "+"
        let length = s.count
        
        for i in 0..<length {
            let item = s[i]
            if item.isNumber, let x = Int(String(item)) {
                currVal = currVal * 10 + x
            }
            if !item.isDigit && !item.isWhitespace || i == length - 1 {
                if operatorVal == "+" || operatorVal == "-" {
                    result += lastVal
                    lastVal = operatorVal == "+" ? currVal : -currVal
                }
                else if operatorVal == "*" {
                    lastVal = currVal * lastVal
                }
                else if operatorVal == "/" {
                    lastVal = lastVal / currVal
                }
                operatorVal = String(item)
                currVal = 0
            }
        }
        result += lastVal
        return result
    }
    
    static func maximalSquare(_ matrix: [[Character]]) -> Int {
        if matrix.isEmpty {
            return 0
        }
        
        let m = matrix.count
        let n = matrix[0].count
        var dpMat = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
        var length = 0
        for i in 1..<m {
            for j in 1..<n {
                if matrix[i - 1][j - 1] == "1" {
                    let x = dpMat[i - 1][j - 1]
                    let y = dpMat[i][j - 1]
                    let z = dpMat[i - 1][j]
                    dpMat[i][j] = min(x, y, z) + 1
                    length = max(length, dpMat[i][j])
                }
            }
        }
        
        return length * length
    }
    
    func computeArea(_ A: Int, _ B: Int, _ C: Int, _ D: Int, _ E: Int, _ F: Int, _ G: Int, _ H: Int) -> Int {
        var totalArea = abs(C - A) * abs(D - B) + abs(G - E) * abs(H - F)
        
        if max(A, E) < min(C, G) && max(B, F) < min(D, H) {
            totalArea -= abs((min(C, G) - max(A, E)) * (min(D, H) - max(B, F)))
        }
        
        return totalArea
    }
    
    func reorderList(_ head: SortedNode?) {
        if head == nil {
            return
        }
        
        var slow: SortedNode? = head
        var fast: SortedNode? = head
        
        while slow != nil && fast?.next?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        var prev: SortedNode?
        var temp: SortedNode?
        var curr = slow
        
        while curr != nil {
            temp = curr?.next
            curr?.next = prev
            prev = curr
            curr = temp
        }
        
        var first = head
        var second = prev
        while second?.next != nil {
            temp = first?.next
            first?.next = second
            first = temp
            
            temp = second?.next
            second?.next = first
            second = temp
        }
    }
    
    func reverseBetween(_ head: SortedNode?, _ m: Int, _ n: Int) -> SortedNode? {
        if head == nil {
            return nil
        }
        
        var headVal = head
        var p1 = head
        var curr = head
        var mVal = m
        var nVal = n
        while m > 1 {
            p1 = curr
            curr = curr?.next
            mVal -= 1
            nVal -= 1
        }
        
        var temp: SortedNode?
        var prev: SortedNode?
        let trail = curr
        
        while nVal > 0 {
            temp = curr?.next
            curr?.next = prev
            prev = curr
            curr = temp
            nVal -= 1
        }
        
        if p1 != nil {
            p1?.next = prev
        }
        else {
            headVal = prev
        }
        
        trail?.next = curr
        
        return headVal
    }
    
    static func merge(_ intervals: [[Int]]) -> [[Int]] {
        if intervals.isEmpty {
            return []
        }
        
        var list = intervals.sorted { (first, second) -> Bool in
            return first[0] < second[0]
        }
        
        var i = 0
        while i < list.count - 1 {
            let curr = list[i]
            let next = list[i + 1]
            if (curr[1] > next[0]) || (next[0] <= curr[0] && next[1] >= curr[1]) {
                list[i] = [min(curr[0], next[0]), max(curr[1], next[1])]
                list.remove(at: i + 1)
            }
            else {
                i += 1
            }
        }
        return list
    }
    
    func increasingTriplet(_ nums: [Int]) -> Bool {
        if nums.isEmpty {
            return false
        }
        
        let length = nums.count
        var lis = Array(repeating: 1, count: length)
        for i in 1..<length {
            lis[i] = 1
            for j in 0..<i {
                if nums[i] > nums[j] && lis[i] < lis[j] + 1 {
                    lis[i] = lis[j] + 1
                }
            }
        }
        
        return lis.contains(3)
    }
    
    func increasingTripletV2(_ nums: [Int]) -> Bool {
        if nums.isEmpty {
            return false
        }
        
        var first = Int.max
        var second = Int.max
        
        for item in nums {
            if item <= first {
                first = item
            }
            else if item <= second {
                second = item
            }
            else {
                return true
            }
        }
        return false
    }
    
    func connectHelper(_ root: NextConnectedNode?, _ map: inout [Int: NextConnectedNode?], _ level: Int) {
        if root == nil {
            return
        }
        
        if let val = map[level] {
            val?.next = root
            map[level] = root
        }
        else {
            map[level] = root
        }
        
        connectHelper(root?.left, &map, level + 1)
        connectHelper(root?.right, &map, level + 1)
    }
    
    func connect(_ root: NextConnectedNode?) -> NextConnectedNode? {
        if root == nil {
            return nil
        }
        var levelMap = [Int: NextConnectedNode?]()
        connectHelper(root, &levelMap, 0)
        return root
    }
    
    func widthOfBinaryTreeHelper(_ root: TreeNode?, _ map: inout [Int: Int], _ level: Int) {
        if root == nil {
            return
        }
        
        if var val = map[level] {
            val += 1
            map[level] = val
        }
        else {
            map[level] = 1
        }
        
        if root?.left == nil || root?.right == nil {
            if var val = map[level + 1] {
                val += 1
                map[level + 1] = val
            }
            else {
                map[level + 1] = 1
            }
        }
        
        widthOfBinaryTreeHelper(root?.left, &map, level + 1)
        widthOfBinaryTreeHelper(root?.right, &map, level + 1)
    }
    
    func widthOfBinaryTree(_ root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        var levelMap = [Int: Int]()
        widthOfBinaryTreeHelper(root, &levelMap, 0)
        var mavVal = Int.min
        for item in levelMap {
            let x = item.value
            if mavVal < x {
                mavVal = x
            }
        }
        return mavVal
    }
    
    static func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        if s.isEmpty || wordDict.isEmpty {
            return false
        }
        
        let length = s.count
        let queue = Queue<Int>()
        var visited = Array(repeating: 0, count: length)
        queue.enqueue(val: 0)
        
        while !queue.isEmpty {
            let start = queue.dQueue()
            if visited[start] == 0 {
                for end in start..<length {
                    let x = s.index(s.startIndex, offsetBy: start)
                    let y = s.index(s.startIndex, offsetBy: end)
                    let subStr = String(s[x...y])
                    if wordDict.contains(subStr) {
                        queue.enqueue(val: end + 1)
                        if end == length - 1 {
                            return true
                        }
                    }
                }
                visited[start] = 1
            }
        }
        
        return false
    }
    
    static func findClosestElements(_ arr: [Int], _ k: Int, _ x: Int) -> [Int] {
        if arr.isEmpty {
            return []
        }
        
        let length = arr.count

        if x <= arr[0] {
            return Array(arr[0..<k])
        }
        else if x >= arr[length - 1] {
            return Array(arr[length - k..<length])
        }
        else {
            var index = binarySearchGivePosition(list: arr, start: 0, end: length - 1, element: x)
            if index < 0 {
                index = -index - 1
            }
            
            var low = max(0, index - k - 1)
            var high = min(length - 1, index + k - 1)
            
            while high - low > k - 1 {
                if low < 0 || (x - arr[low]) <= (arr[high] - x) {
                    high -= 1
                }
                else if high > length - 1 || (x - arr[low]) > (arr[high] - x) {
                    low += 1
                }
            }
            
            return Array(arr[low...high])
        }
    }
    
    func findMin(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        var curr = root
        while curr?.left != nil {
            curr = curr?.left
        }
        return curr
    }
    
    func inorderSuccessor(_ root: TreeNode?, _ p: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        if p?.right != nil {
            return findMin(p?.right)
        }
        
        var succ: TreeNode?
        var rootNode = root
        while rootNode != nil {
            if let pVal = p?.value, let rootVal = rootNode?.value {
                if pVal < rootVal {
                    succ = rootNode
                    rootNode = rootNode?.left
                }
                else if pVal > rootVal {
                    rootNode = rootNode?.right
                }
                else {
                    break
                }
            }
        }
        
        return succ
    }
    
    static func longestSubstring(_ s: String, _ k: Int) -> Int {
        if s.isEmpty {
            return 0
        }
        
        let length = s.count
        if length < k {
            return 0
        }
        
        var map = [Character: Int]()
        for item in s {
            if let val = map[item] {
                map[item] = val + 1
            }
            else {
                map[item] = 1
            }
        }
        
        var index = 0
        while index < length {
            let item = s[index]
            if let x = map[item], x >= k {
                
            }
            else {
                var j = index + 1
                while j < length, let y = map[s[j]], y < k {
                    j += 1
                }
                
                let first = s[0, index - 1]
                let second = s[j, length - 1]
                return max(longestSubstring(first, k), longestSubstring(second, k))
            }
            index += 1
        }
        return length
    }
    
    static func lengthOfLIS(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        let length = nums.count
        var lis = Array(repeating: 1, count: length)
        
        for i in 1..<length {
            lis[i] = 1
            for j in 0..<i {
                if nums[i] > nums[j] && lis[i] < lis[j] + 1 {
                    lis[i] = lis[j] + 1
                }
            }
        }
        
        var max = Int.min
        for item in lis {
            if max < item {
                max = item
            }
        }
        return max
    }
    
    static func findMaxLength(_ nums: [Int]) -> Int {
        let length = nums.count
        if length <= 1 {
            return 0
        }
        
        var maxLen = Int.min
        var map = [Int: Int]()
        map[0] = -1
        var count = 0
        for i in 0..<length {
            count = count + (nums[i] == 1 ? 1 : -1)
            if let x = map[count] {
                maxLen = max(maxLen, i - x)
            }
            else {
                map[count] = i
            }
        }
        return max(0, maxLen)
    }
    
    static func numFriendRequests(_ ages: [Int]) -> Int {
        let length = ages.count
        if length <= 1 {
            return 0
        }
        
        var countList = Array(repeating: 0, count: 121)
        for age in ages {
            var val = countList[age]
            val += 1
            countList[age] = val
        }
        
        var result = 0
        for ageA in 0...120 {
            let countA = countList[ageA]
            for ageB in 0...120 {
                let countB = countList[ageB]
                if (ageB <= ageA/2 + 7) || ageB > ageA || ageB > 100 && ageA < 100 {}
                else {
                    result += countA * countB
                    if ageA == ageB {
                        result -= countA
                    }
                }
            }
        }
        return result
    }
    
    static func findPeakElement(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return -1
        }
        
        let length = nums.count
        
        if length == 1 {
            return 0
        }
        else if length == 2 {
            return nums[0] > nums [1] ? 0 : 1
        }
        
        for index in 1..<length - 1 {
            if nums[index] > nums[index - 1] && nums[index] > nums[index + 1] {
                return index
            }
        }
        return nums[0] > nums[length - 1] ? 0 : length - 1
    }
    
    static func eraseOverlapIntervals(_ intervals: [[Int]]) -> Int {
        if intervals.isEmpty || intervals.count == 1 {
            return 0
        }
        
        var list = intervals.sorted { $0[0] < $1[0] }
        var index = 1
        var counter = 0
        while index < list.count {
            if list[index][1] < list[index - 1][1] {
                counter += 1
                list.remove(at: index - 1)
            }
            else if list[index][0] < list[index - 1][1] {
                counter += 1
                list.remove(at: index)
            }
            else {
                index += 1
            }
        }
        return counter
    }
    
    static func setZeroes(_ matrix: inout [[Int]]) {
        if matrix.isEmpty {
            return
        }
        
        let m = matrix.count
        let n = matrix[0].count
        var isCol = false
        for i in 0..<m {
            if matrix[i][0] == 0 {
                isCol = true
            }
            for j in 1..<n {
                if matrix[i][j] == 0 {
                    matrix[i][0] = 0
                    matrix[0][j] = 0
                }
            }
        }
        
        for i in 1..<m {
            for j in 1..<n {
                if matrix[i][0] == 0 || matrix[0][j] == 0 {
                    matrix[i][j] = 0
                }
            }
        }
        
        if matrix[0][0] == 0 {
            for j in 0..<n {
                matrix[0][j] = 0
            }
        }
        
        if isCol {
            for i in 0..<m {
                matrix[i][0] = 0
            }
        }
    }
    
    // sum[i] - sum[j] = k i.e. sum[i] - k = sum[j] i.e. sum till ith index and sum till jth index
    static func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        if nums.isEmpty {
            return 0
        }
        
        var sum = 0
        var map = [Int: Int]()
        map[0] = 1
        var count = 0
        
        for item in nums {
            sum += item
            if let x = map[sum - k] {
                count += x
            }
            if let y = map[sum] {
                map[sum] = y + 1
            }
            else {
                map[sum] = 1
            }
        }
        
        return count
    }
    
    func distanceFromTarget(_ root: TreeNode?, _ k: Int) -> (Int, TreeNode?) {
        if root == nil {
            return (-1, nil)
        }
        
        if let rootVal = root, rootVal.value == k {
            return (0, root)
        }
        let left = distanceFromTarget(root?.left, k)
        let right = distanceFromTarget(root?.right, k)
        if left.0 != -1 {
            return (left.0 + 1, left.1)
        }
        else if right.0 != -1 {
            return (right.0 + 1, right.1)
        }
        return (-1, nil)
    }
    
    func findClosestLeaf(_ root: TreeNode?, _ k: Int) -> Int {
        if root == nil {
            return 0
        }
        
        let distToTarget = distanceFromTarget(root, k)
        if distToTarget.0 != -1 {
            
        }
        
        
        return 0
    }
    
    static func binarySearch(_ matrix: [[Int]], _ row: Int, _ left: Int, _ right: Int, _ target: Int) -> Bool {
        if left > right {
            return false
        }
        
        let mid = (left + right) / 2
        if matrix[row][mid] == target {
            return true
        }
        else if matrix[row][mid] < target {
            return binarySearch(matrix, row, mid + 1, right, target)
        }
        return binarySearch(matrix, row, left, mid - 1, target)
    }
    
    static func searchMatrix2(_ matrix: [[Int]], _ target: Int) -> Bool {
        
        let m = matrix.count
        guard let first = matrix.first else { return false }
        
        let n = first.count
        
        if matrix.isEmpty || n == 0 {
            return false
        }
        
        if target < matrix[0][0] || target > matrix[m - 1][n - 1] {
            return false
        }
        
        for i in 0..<m {
            if target >= matrix[i][0] && target <= matrix[i][n - 1] {
                return binarySearch(matrix, i, i, n - 1, target)
            }
        }
        return false
    }
    
    func copyRandomList(_ head: RandomNode?) -> RandomNode? {
        guard let root = head else {
            return nil
        }
        
        var map = [RandomNode: RandomNode]()
        
        var curr = head
        while let currVal = curr {
            map[currVal] = RandomNode(currVal.val)
            curr = curr?.next
        }
        
        curr = head
        while let currVal = curr {
            if let x = currVal.next, let y = currVal.random, let clone = map[currVal] {
                clone.next = map[x]
                clone.random = map[y]
            }
            curr = curr?.next
        }
        
        return map[root]
    }
    
    func rotateMatrix90(_ matrix: inout [[Int]]) {
        if matrix.isEmpty {
            return
        }
        
        let n = matrix.count
        
        for x in 0..<n/2 {
            for y in x..<n-x-1 {
                let temp = matrix[x][y]
                matrix[x][y] = matrix[y][n-1-x]
                matrix[y][n-1-x] = matrix[n-1-x][n-1-y]
                matrix[n-1-x][n-1-y] = matrix[n-1-y][x]
                matrix[n-1-y][x] = temp
            }
        }
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
    var neighbours = [GrapthNode]()
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

class ValidWordAbbr {

    private var map = [String: Set<String>]()
    init(_ dictionary: [String]) {
        for item in dictionary {
            let x = getAbbr(item)
            if var val = map[x] {
                val.insert(item)
                map[x] = val
            }
            else {
                var set = Set<String>()
                set.insert(item)
                map[x] = set
            }
        }
    }
    
    func isUnique(_ word: String) -> Bool {
        if word.isEmpty {
            return false
        }
        
        let x = getAbbr(word)
        if let val = map[x] {
            return  val.count == 1 && val.contains(word)
        }
        return true
    }
    
    private func getAbbr(_ s: String) -> String {
        if s.isEmpty {
            return ""
        }
        
        let last = s.index(before: s.endIndex)
        return "\(s[s.startIndex])" + "\(s.count - 2)" + "\(s[last])"
    }
}


class LRUCache {
    var map = [Int : DQNode<Int, Int>]()
    var dq : DQList<Int, Int>
    init(_ capacity: Int) {
        dq = DQList(sizeVal: capacity)
    }
    
    func get(_ key: Int) -> Int {
        if let node = map[key] {
            return node.value
        }
        return -1
    }
    
    func put(_ key: Int, _ value: Int) {
        if let _ = map[key] {
        }
        else {
            let node = dq.insert(key: key, val: value)
            if let key = node.removedKey {
                map[key] = nil
            }
            map[key] = node.addedNode
        }
    }
}

class LargestBSTSolve {
    
    struct CheckBST {
        let count: Int
        let max: Int
        let min: Int
    }
    
    var counter = 0
    @discardableResult
    func largestBSTSubtreeHelper(_ root: TreeNode?) -> CheckBST {
        if root == nil {
            return CheckBST(count: 0, max: -1, min: -1)
        }
        let left = largestBSTSubtreeHelper(root?.left)
        let right = largestBSTSubtreeHelper(root?.right)
        if let rootVal = root, ((left.count == 0 || left.max < rootVal.value) && (right.count == 0 || right.min > rootVal.value)) {
            let count = left.count + right.count + 1
            let min = left.count == 0 ? rootVal.value : left.min
            let max = right.count == 0 ? rootVal.value : right.max
            counter = count > counter ? count : counter
            return CheckBST(count: count, max: max, min: min)
        }
        else {
            return CheckBST(count: 1, max: Int.max, min: Int.min)
        }
    }
    
    func largestBSTSubtree(_ root: TreeNode?) -> Int {
        largestBSTSubtreeHelper(root)
        return counter
    }
}

class NumMatrix {

    private let matval: [[Int]]
    let m: Int
    let n: Int
    init(_ matrix: [[Int]]) {
        matval = matrix
        m = matrix.count
        n = m > 0 ? matrix[0].count : 0
    }
    
    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        var sum = 0
        if row1 >= 0 && row1 < m && row2 >= 0 && row2 < m && col1 >= 0 && col1 < n && col2 >= 0 && col2 < n {
            for i in row1...row2 {
                for j in col1...col2 {
                    sum += matval[i][j]
                }
            }
        }
        return sum
    }
}

class NumMatrixV2 {

    private var matval: [[Int]]
    let m: Int
    let n: Int
    init(_ matrix: [[Int]]) {
        m = matrix.count
        n = m > 0 ? matrix[0].count : 0
        matval = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)
        for i in 0..<m {
            for j in 0..<n {
                matval[i + 1][j + 1] = matval[i + 1][j] + matval[j][j + 1] + matrix[i][j] - matval[i][j]
            }
        }
    }
    
    func sumRegion(_ row1: Int, _ col1: Int, _ row2: Int, _ col2: Int) -> Int {
        var sum = 0
        if row1 >= 0 && row1 < m && row2 >= 0 && row2 < m && col1 >= 0 && col1 < n && col2 >= 0 && col2 < n {
            sum = matval[row2 + 1][col2 + 1] - matval[row2 + 1][col1] - matval[row1][col2 + 1] + matval[row1][col1]
        }
        return sum
    }
}

