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
