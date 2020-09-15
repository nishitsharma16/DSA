//
//  LeetCode.swift
//  DSA
//
//  Created by Nishit on 11/06/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

func swapValues<T>(_ a: inout T, _ b: inout T) {
    let x = a
    a = b
    b = x
}


// Medium
class Problems {
    
    static func addTwoNumbers(list1 : ListNode<Int>?, list2 : ListNode<Int>?) -> ListNode<Int>? {
        if let _ = list1, let _ = list2 {
            var result : ListNode<Int>?
            let finalResult = result
            var val1 = list1
            var val2 = list2
            var remainder = 0
            while val1 != nil && val2 != nil {
                if let item1 = val1?.item, let item2 = val2?.item {
                    let sum = item1 + item2 + remainder
                    result = ListNode<Int>(value: sum % 10)
                    remainder = sum / 10
                }
                val1 = val1?.next
                val2 = val2?.next
                result = result?.next
            }
            
            if let _ = val1 {
                while val1 != nil {
                    if let item1 = val1?.item {
                        let sum = item1 + remainder
                        result = ListNode<Int>(value: sum % 10)
                        remainder = sum / 10
                    }
                    val1 = val1?.next
                    result = result?.next
                }
            }
            
            if let _ = val2 {
                while val2 != nil {
                    if let item2 = val2?.item {
                        let sum = item2 + remainder
                        result = ListNode<Int>(value: sum % 10)
                        remainder = sum / 10
                    }
                    val2 = val2?.next
                    result = result?.next
                }
            }
            return finalResult
        }
        else if let root1 = list1 {
            return root1
        }
        else if let root2 = list2 {
            return root2
        }
        return nil
    }
    
    static func lengthOfLongestSubstring(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        
        if s.count == 1 {
            return 1
        }
        
        var info = [Character : String.Index]()
        
        var str = ""
        var maxLength = Int(INT16_MIN)
        var startIndex = s.startIndex
    
        while startIndex < s.endIndex {
            let val = s[startIndex]
            if let x = info[val] {
                if maxLength < str.count {
                    maxLength = str.count
                }
                startIndex = s.index(after: x)
                info.removeAll()
                str = ""
            }
            else {
                str += String(val)
                info[val] = startIndex
                startIndex = s.index(after: startIndex)
            }
        }
        if !str.isEmpty {
            if maxLength < str.count {
                maxLength = str.count
            }
        }
        return maxLength
    }
    
    
    static func longestPalindrome(_ s: String) -> String {
        if s.isEmpty {
            return ""
        }
        
        if s.count == 1 {
            return s
        }
        
        var str = ""
        var maxLength = Int(INT16_MIN)
        let subStrings = s.getAllSubstrings()
        for item in subStrings {
            if item.checkStringIsPalindrome() {
                if maxLength < item.count {
                    maxLength = item.count
                    str = item
                }
            }
        }
        
        return str
    }
    
    static func longestPalindromeDP(_ s: String) -> String {
        if s.isEmpty {
            return ""
        }
        
        if s.checkStringIsPalindrome() {
            return s
        }
        
        let length = s.count
        var statusList = Array(repeating: Array(repeating: false, count: length), count: length)
        var maxLength = 1
        var start = 0
        
        for index in 0..<length {
            statusList[index][index] = true
        }
        
        for index in 0..<length-1 {
            if s[index] == s[index+1] {
                statusList[index][index+1] = true
                start = index
                maxLength = 2
            }
        }
        
        if length <= 2 {
            return s[start,start+maxLength-1]
        }
        
        var j = 0
        
        for l in 3...length {
            for i in 0..<length - l + 1 {
                j = i + l - 1
                if statusList[i+1][j-1] && s[i] == s[j] {
                    statusList[i][j] = true
                    maxLength = l
                    start = i
                }
            }
        }
        
        return s[start,start+maxLength-1]
    }
    
    static func getColCount(rows: Int, length: Int) -> Int {
        if rows <= 0 || length <= 0 {
            return 0
        }
        
        let maxLettersTillDiagnal = rows + (rows - 2)
        let dividend = length / maxLettersTillDiagnal
        let mod = length % maxLettersTillDiagnal
        if mod == 0 {
            return dividend * (1 + (rows - 2))
        }
        else {
            var extraRow = mod / rows
            if extraRow == 0 {
                extraRow = 1
            }
            else {
                extraRow = (mod / rows) + (mod % rows)
            }
            return dividend * (1 + (rows - 2)) + extraRow
        }
    }
    
    static func createMat(str: String, rows: Int, col: Int) -> [[String]] {
        var mat = Array(repeating: Array(repeating: "0", count: col), count: rows)
        var x = 0
        var y = 0
        var index = str.startIndex
        var moveVertical = true
        
        while index < str.endIndex {
            let val = String(str[index])
            if moveVertical {
                if x < rows {
                    mat[x][y] = val
                    x += 1
                }
            }
            else {
                x -= 1
                y += 1
                mat[x][y] = val
            }
            if moveVertical {
                if x == rows {
                    x -= 1
                    moveVertical = false
                }
            }
            else {
                if x == 0 {
                    x += 1
                    moveVertical = true
                }
            }
            index = str.index(after: index)
        }
        
        return mat
    }
    
    static func getZigZagTraversalString(_ str: String, _ rows: Int, currRow: Int, result: inout String) {
        let length = str.count
        let colVal = getColCount(rows: rows, length: length)
        let mat = createMat(str: str, rows: rows, col: colVal)
        
        for i in 0..<rows {
            for j in 0..<colVal {
                let val = mat[i][j]
                if val != "0" {
                    result += val
                }
            }
        }
    }
    
    static func zigZagConversion(_ s: String, _ numRows: Int) -> String {
        if s.isEmpty {
            return ""
        }
        else if numRows == 0 || numRows == 1 {
            return s
        }
        
        var result = ""
        
        getZigZagTraversalString(s, numRows, currRow: 0, result: &result)
        
        return result
    }
    
    static func sumOfThreeNumber(list : [Int], sum : Int) -> [[Int]] {
        if list.isEmpty {
            return []
        }
        
        var result = [[Int]]()
        
        for index in 0..<list.count - 1 {
            var set = Set<Int>()
            let x = sum - list[index]
            
            for i in index + 1..<list.count {
                if set.contains(x - list[i]) {
                    result.append([list[index], list[i], x - list[i]])
                }
                else {
                    set.insert(list[i])
                }
            }
        }
        
        return result
    }
    
    
    // Pending
    static func containerWithMostWater(list: [Int]) -> Int {
        if list.isEmpty {
            return 0
        }
        
        var start = 0
        var max1 = start
        var max2 = start + 1
        var area1 = 0
        var area2 = 0
        
        for index in 2..<list.count {
            
            if list[index] > list[max2] {
                area1 = (index - max1) * min(list[index], list[max1])
                area2 = (index - max2) * min(list[index], list[max2])
                if area1 > area2 {
                    max2 = index
                }
                else {
                    max1 = max2
                    max2 = index
                }
            }
            
            
            if list[index] >= list[max2] {
                max2 = index
            }
        }
        let maxArea = (max2 - max1) * min(list[max1], list[max2])
        return maxArea
    }
    
    static func aToI(str: String) -> Int {
        if str.isEmpty {
            return 0
        }
        
        let stringWithoutTrailingWhiteSpaces = str.removeWhiteSpaceCharFromStartAndEnd()
        if stringWithoutTrailingWhiteSpaces.isEmpty {
            return 0
        }
        
        var isNegative = false
        if let status = stringWithoutTrailingWhiteSpaces.isNegative() {
            isNegative = status
        }
        
        var result = 0
        
        for index in 0..<stringWithoutTrailingWhiteSpaces.count {
            let val = stringWithoutTrailingWhiteSpaces[index]
            if val.isDigit, let x = val.intVal {
                result = result*10 + x
            }
            else {
                break
            }
        }
        
        if isNegative {
            if result < Int.min {
                return Int.min
            }
            return -result
        }
        else {
            if result > Int.max {
                return Int.max
            }
            return result
        }
    }
    
    static func intToRoman(value: Int) -> String {
        var result = ""
        var target = value
        let values = [10, 9, 5, 4, 1]
        let symbols = ["X", "IX", "V", "IV", "I"]
        for i in 0..<values.count {
            while values[i] <= target {
                target -= values[i]
                result += symbols[i]
            }
            if target == 0 {
                break
            }
        }
        return result
    }
    
    static func closest3Sum(list: [Int], target: Int) -> Int {
        var result = Int.max
        
        if list.isEmpty {
            return result
        }
        
        var set = Set<Int>()
        
        for i in 0..<list.count {
            let x = target - list[i]
            for j in i+1..<list.count {
                let y = x - list[j]
                if set.contains(y) {}
                else {
                    set.insert(list[j])
                    let sum = list[i] + list[j] + y
                    let val = abs(sum - target)
                    if result > val {
                        result = val
                    }
                }
            }
        }
        
        return result
    }
    
    static func mapping() -> [String: String] {
        return ["2" : "abc", "3" : "def", "4" : "ghi", "5" : "jkl", "6" : "mno", "7" : "pqrs", "8" : "tuv", "9" : "wxyz"]
    }
    
    static func getOtherConbination(str: String, prevList: inout [String]) {
        if str.isEmpty {
            return
        }
        
        if prevList.isEmpty {
            for index in 0..<str.count {
                let val = String(str[index])
                prevList.append(val)
            }
        }
        else {
            let values = prevList
            prevList.removeAll()
            for index in 0..<str.count {
                for item in values {
                    let val = item + String(str[index])
                    prevList.append(val)
                }
            }
        }
    }
    
    static func getStringCombination(str: String) -> [String] {
        if str.isEmpty {
            return []
        }
        
        let length = str.count
        
        let mappingVal = mapping()
        var result = [String]()
        
        for i in 0..<length {
            if let mappedValue = mappingVal[String(str[i])] {
                getOtherConbination(str: mappedValue, prevList: &result)
            }
        }
        
        return result
    }
    
    static func get4Sum(list: [Int], target: Int) -> [[Int]] {
        if list.isEmpty {
            return []
        }
        
        let length = list.count
        var info = Dictionary<Int, (i: Int, j: Int)>()
        
        for i in 0..<length-1 {
            for j in i+1..<length {
                info[list[i] + list[j]] = (i, j)
            }
        }
        
        var result = [[Int]]()
        var tempInfo = Dictionary<String, [Int]>()
        var tempList = [[Int]]()

        for i in 0..<length-1 {
            for j in i+1..<length {
                let sum = list[i] + list[j]
                let value = target - sum
                if let x = info[value] {
                    if x.i != i && x.j != j && x.j != i && x.i != j {
                        tempList.append([list[x.i], list[x.j], list[i], list[j]])
                    }
                }
            }
        }
        
        for item in tempList {
            let listVal = item.sorted()
            let key = listVal.stringVal
            if let _ = tempInfo[key] {
                
            }
            else {
                tempInfo[key] = listVal
                result.append(listVal)
            }
        }
        
        return result
    }
    
    static func removeNthNodeFromEnd(root: inout ListNode<Int>?, n: Int) {
        if let _ = root {
            var counter = 0
            var current = root
            while current?.next != nil && counter < n {
                current = current?.next
                counter += 1
            }
            var temp = root
            while current?.next != nil {
                current = current?.next
                temp = temp?.next
            }
            if let _ = temp?.next {
                var tempNext = temp?.next
                temp?.item = tempNext?.item ?? 0
                temp?.next = tempNext?.next
                tempNext = nil
            }
        }
    }
    
    static func processPrantheses(str: String, type: Int) -> [String] {
        if str.isEmpty {
            return []
        }
        
        var list = [String]()
        let start = "("
        let end = ")"
        
        switch type {
        case 1:
            print("Type 1")
            let val = start + str + end
            list.append(val)
        case 2:
            print("Type 2")
            let val1 = str + start + end
            let val2 = start + end + str
            if val1 == val2 {
                list.append(val1)
            }
            else {
                list.append(contentsOf: [val1, val2])
            }
        default:
            print("None")
        }
        return list
    }
    
    static func generateParantheses(n: Int) -> Set<String> {
        if n <= 0 {
            return []
        }
        
        let start = "("
        let end = ")"
        let first = start + end
        
        if n == 1 {
            return [first]
        }
        
        var list = [String]()
        list.append(first)
        
        var counter = n - 1
        while counter > 0 {
            var x = [String]()
            for item in list {
                let y = processPrantheses(str: item, type: 1) + processPrantheses(str: item, type: 2)
                x.append(contentsOf: y)
            }
            list.removeAll()
            list.append(contentsOf: x)
            counter -= 1
        }
        
        var finalVal = Set<String>()
        for item in list {
            finalVal.insert(item)
        }
        
        return finalVal
    }
    
    static func divideNumbers(dividend: Int, divisor: Int, counter: Int) -> Int {
        if dividend <= 0 {
            return 0
        }
        else if dividend < divisor {
            return counter
        }
        else {
            let x = dividend - divisor
            let y = counter + 1
            return divideNumbers(dividend: x, divisor: divisor, counter: y)
        }
    }
    
    static func divideTwoInteger(dividend: Int, divisor: Int) -> Int {
        if dividend == 0 {
            return 0
        }
        else if divisor == 0 {
            return Int.max
        }
        else {
            let val = divideNumbers(dividend: abs(dividend), divisor: abs(divisor), counter: 0)
            return dividend < 0 || divisor < 0 ? -val : val
        }
    }
    
    static func findPivotPosition(list: [Int], start: Int, end: Int) -> Int {
        if start > end {
            return -1
        }
        let mid = (start + end)/2
        if list[mid] > list[mid + 1] && list[mid] < list[mid - 1] {
            return mid
        }
        else if list[mid] < list[mid + 1] {
            return findPivotPosition(list: list, start: mid + 1, end: end)
        }
        else {
            return findPivotPosition(list: list, start: start, end: mid - 1)
        }
    }
    
    static func binarySearchGivePosition(list: [Int], start: Int, end: Int, element: Int) -> Int {
        if start > end {
            return -1
        }
        
        let mid = (start + end)/2
        if list[mid] == element {
            return mid
        }
        else if element < list[mid] {
            return binarySearchGivePosition(list: list, start: start, end: mid - 1, element: element)
        }
        else {
            return binarySearchGivePosition(list: list, start: mid + 1, end: end, element: element)
        }
    }
    
    static func binarySearch(list: [Int], start: Int, end: Int, element: Int) -> Bool {
        if start > end {
            return false
        }
        
        let mid = (start + end)/2
        if list[mid] == element {
            return true
        }
        else if element < list[mid] {
            return binarySearch(list: list, start: start, end: mid - 1, element: element)
        }
        else {
            return binarySearch(list: list, start: mid + 1, end: end, element: element)
        }
    }
    
    static func searchInSortedRotedArray(list: [Int], element: Int) -> Bool {
        if list.isEmpty {
            return false
        }
        
        let length = list.count
        let start = 0
        let end = length - 1
        
        let pivot = findPivotPosition(list: list, start: start, end: end)
        if list[pivot] == element {
            return true
        }
        else if list[start] < element && element < list[pivot] {
            return binarySearch(list: list, start: start, end: pivot, element: element)
        }
        else {
            return binarySearch(list: list, start: pivot + 1, end: end, element: element)
        }
    }
    
    static func findFirstPosition(list: [Int], item: Int, start: Int, end: Int) -> Int {
        if start > end {
            return -1
        }
        let mid = (start + end)/2
        if list[mid] == item && mid == 0 {
            return mid
        }
        else if list[mid] == item && list[mid - 1] < list[mid] {
            return mid
        }
        else if item > list[mid] {
            return findFirstPosition(list: list, item: item, start: mid + 1, end: end)
        }
        else {
            return findFirstPosition(list: list, item: item, start: start, end: mid - 1)
        }
    }
    
    static func findLastPosition(list: [Int], item: Int, start: Int, end: Int) -> Int {
        if start > end {
            return -1
        }
        let mid = (start + end)/2
        if list[mid] == item && mid == list.count - 1 {
            return mid
        }
        else if list[mid] == item && list[mid] < list[mid + 1] {
            return mid
        }
        else if item > list[mid] {
            return findLastPosition(list: list, item: item, start: mid + 1, end: end)
        }
        else {
            return findLastPosition(list: list, item: item, start: start, end: mid - 1)
        }
    }
    
    static func findFirstAndLastPositionOfItem(list: [Int], item: Int) -> (first: Int, last: Int) {
        if list.isEmpty {
            return (-1, -1)
        }
        
        let length = list.count
        let start = 0
        let end = length - 1
        if length == 1 {
            if list[0] != item {
                return (-1, -1)
            }
            return (0, 0)
        }
        
        let firstPosition = findFirstPosition(list: list, item: item, start: start, end: end)
        if list[end] == item {
            return (firstPosition, end)
        }
        let lastPosition = findLastPosition(list: list, item: item, start: firstPosition, end: end)
        
        return (firstPosition, lastPosition)
    }
    
    static func findCombinationSum(list: [Int], target: Int) -> [[Int]] {
        var result = [[Int]]()
        
        if list.isEmpty {
            return result
        }
        
        if list[0] > target {
            return result
        }
        
        var tempInfo = Dictionary<String, [Int]>()
        var tempList = [[Int]]()
        
        for index in 0..<list.count {
            let item = list[index]
            let remainder = target % item
            if remainder == 0 {
                tempList.append(Array<Int>(repeating: item, count: target / item))
            }
            else {
                let itemPosition = binarySearchGivePosition(list: list, start: 0, end: index - 1, element: remainder)
                if itemPosition != -1 {
                    var listVal = Array<Int>(repeating: item, count: target / item)
                    listVal.append(list[itemPosition])
                    tempList.append(listVal)
                }
                else {
                    var sum = 0
                    var remainderSum = 0
                    var temp = [Int]()
                    for innerIndex in 0...index {
                        let item = list[innerIndex]
                        let remainder = target % item
                        remainderSum += remainder
                        sum += item + remainder
                        temp.append(item)
                    }
                    if target % sum == 0 {
                        temp.append(remainderSum)
                        tempList.append(temp)
                    }
                }
            }
        }
        
        for item in tempList {
            let listVal = item.sorted()
            let key = listVal.stringVal
            if let _ = tempInfo[key] {
                
            }
            else {
                tempInfo[key] = listVal
                result.append(listVal)
            }
        }
        
        return result
    }
    
    
    static func getDuplicateCountSet2(list: inout [Int]) -> Int {
        if list.isEmpty {
            return 0
        }
        
        var counter = 0
        list.sort()
        var index = 0
        while index < list.count - 1 {
            if list[index] == list[index + 1] {
                list.remove(at: index)
                counter += 1
            }
            else {
                index += 1
            }
        }
        
        return counter
    }
    
    static func getDuplicateCount(list: inout [Int]) -> Int {
        if list.isEmpty {
            return 0
        }
        
        var counter = 0
        list.sort()
        var index = 0
        while index < list.count - 1 {
            if list[index] == list[index + 1] {
                list.remove(at: index)
                counter += 1
            }
            else {
                index += 1
            }
        }
        
        return counter
    }
    
    static func removeDuplicates(list: inout [Int]) {
        if list.isEmpty {
            return
        }
        
        list.sort()
        var index = 0
        while index < list.count - 1 {
            if list[index] == list[index + 1] {
                list.remove(at: index)
            }
            else {
                index += 1
            }
        }
    }
    
    static func combinationSum(list: [Int], sum: Int, temp: inout [Int], result: inout [[Int]], index: Int) {
        if sum < 0 {
            return
        }
        
        if sum == 0 {
            result.append(temp)
            return
        }
        
        var indexVal = index
        while indexVal < list.count && sum - list[indexVal] >= 0 {
            temp.append(list[indexVal])
            combinationSum(list: list, sum: sum - list[indexVal], temp: &temp, result: &result, index: indexVal)
            indexVal += 1
            temp.removeAll()
        }
    }
    
    static func getCombinationSum(list: [Int], sum: Int) -> [[Int]] {
        var tempList = [Int]()
        var result = [[Int]]()
        var listVal = list
        removeDuplicates(list: &listVal)
        combinationSum(list: listVal, sum: sum, temp: &tempList, result: &result, index: 0)
        return result
    }
    
    
    static func combinationSum2(list: [Int], target: Int, sum: inout Int, temp: inout [Int], result: inout [[Int]], index: Int) {
        if sum < 0 {
            return
        }
        
        if sum == 0 {
            result.append(temp)
            return
        }
        
        if sum + list[index] > target {
            return
        }
        
        var indexVal = index
        while indexVal < list.count {
            temp.append(list[indexVal])
            sum = sum + list[indexVal]
            indexVal += 1
            combinationSum(list: list, sum: sum, temp: &temp, result: &result, index: indexVal)
            sum -= list[indexVal]
            temp.removeAll()
        }
    }
    
    static func helperCombinationSum2(list: [Int], target: Int, index: Int, length: Int) -> [Int] {
        let stack = Stack<Int>()
        let val = list[0]
        var sum = 0
        var tempList = [Int]()
        for i in 0..<length {
            let curr = list[i]
            if sum + curr > target {
                while sum + curr > target {
                    if let top = stack.top() {
                        let x = list[top]
                        sum -= x
                        stack.pop()
                    }
                }
            }
            else {
                sum += curr
                stack.push(val: i)
                tempList.append(val)
                if sum == target {
                    return tempList
                }
            }
        }
        return []
    }
    
    static func getCombinationSum2(list: [Int], target: Int) -> [[Int]] {
        var result = [[Int]]()
        let listVal = list.sorted()
        let length = listVal.count
        
        for i in 0..<length {
            let val = helperCombinationSum2(list: listVal, target: target, index: i, length: length)
            result.append(val)
        }
        return result
    }
    
    static func addTwoNumbers(str1: String, str2: String) -> String {
        if str1.isEmpty && !str2.isEmpty {
            return str2
        }
        else if !str1.isEmpty && str2.isEmpty {
            return str1
        }
        
        var counter1 = str1.count - 1
        var counter2 = str2.count - 1
        var str = ""
        var carry = 0
        while counter1 >= 0 && counter2 >= 0 {
            if let x = Int(String(str1[counter1])), let y = Int(String(str2[counter2])) {
                let sum = x+y + carry
                let remainder = sum % 10
                str = "\(remainder)" + str
                carry = sum / 10
                counter2 -= 1
                counter1 -= 1
            }
        }
        if counter1 >= 0 {
            while counter1 >= 0 {
                if let x = Int(String(str1[counter1])) {
                    let sum = x + carry
                    let remainder = sum % 10
                    str = "\(remainder)" + str
                    carry = sum / 10
                }
                counter1 -= 1
            }
        }
        
        if counter2 >= 0 {
            while counter2 >= 0 {
                if let y = Int(String(str1[counter2])) {
                    let sum = y + carry
                    let remainder = sum % 10
                    str = "\(remainder)" + str
                    carry = sum / 10
                }
                counter2 -= 1
            }
        }
        
        return str
    }
    
    static func multiplyStrings(str1: String, str2: String) -> String {
        var counter2 = str2.count - 1
        var list = [String]()
        while counter2 >= 0 {
            if let x = Int(String(str2[counter2])) {
                var counter1 = str1.count - 1
                var remainder = 0
                var carry = 0
                var str = ""
                while counter1 >= 0 {
                    if let y = Int(String(str1[counter1])) {
                        let multiply = x*y + carry
                        remainder = multiply % 10
                        str = "\(remainder)" + str
                        carry = multiply / 10
                    }
                    counter1 -= 1
                }
                list.append(str)
            }
            counter2 -= 1
        }
        
        var finalList = [String]()
        
        for index in 0..<list.count {
            var val = list[index]
            for _ in 0..<index {
                val += "0"
            }
            finalList.append(val)
        }
        
        var result = ""
        for item in finalList {
            result = addTwoNumbers(str1: item, str2: result)
        }
        
        return result
    }
    
    static func getPermutaionOfDistinctIntegerHelper(list: inout [Int], left: Int, right: Int, result: inout [[Int]]) {
        if left == right {
            result.append(list)
            return
        }
        
        for i in left..<list.count {
            list.swapAt(i, left)
            getPermutaionOfDistinctIntegerHelper(list: &list, left: left + 1, right: right, result: &result)
            list.swapAt(i, left)
        }
    }
    
    static func getPermutaionOfDistinctInteger(list: [Int]) -> [[Int]] {
        if list.isEmpty {
            return []
        }
        
        var listVal = list
        var result = [[Int]]()
        getPermutaionOfDistinctIntegerHelper(list: &listVal, left: 0, right: list.count - 1, result: &result)
        return result
    }
    
    static func getDistinctPermutaionsOfListWithDuplicateIntegers(list: [Int]) -> [[Int]] {
        return []
    }
    
    static func rotateMatrixHelper(mat: inout [[Int]], start: Int, end: Int) {
        var x = start
        var y = start
        var next: (i: Int, j: Int) = (start, start)
        var current: (i: Int, j: Int) = (-1, -1)
        var temp1 = mat[x][y]
        var temp2 = 0
        while true {
            if current.i == start && current.j == start {
                break
            }
            if next.i == start && next.j < end {
                y += 1
                next.j = y
            }
            else if next.j == end && next.i < end {
                x += 1
                next.i = x
            }
            else if next.i == end && next.j > start  {
                y -= 1
                next.j = y
            }
            else if next.j == start && next.i > start {
                x -= 1
                next.i = x
            }
            temp2 = mat[next.i][next.j]
            mat[next.i][next.j] = temp1
            temp1 = temp2
            current = next
        }
    }
    
    static func rotateMatrix(mat: [[Int]]) -> [[Int]] {
        var result = mat
        let length = mat.count
        let numberOfCircles = length / 2
        var start = 0
        var end = length - 1
        for _ in 0..<numberOfCircles {
            for _ in 0..<end - start {
                rotateMatrixHelper(mat: &result, start: start, end: end)
            }
            start += 1
            end -= 1
        }
        return result
    }
    
    static func groupAnagram(list: [String]) -> [[String]] {
        if list.isEmpty {
            return []
        }
        
        var map = [AnyHashable: [String]]()
        let val = list[0]
        var sortedVal = val.sort()
        map[sortedVal] = [val]
        
        for index in 1..<list.count {
            let item = list[index]
            sortedVal = item.sort()
            if var x = map[sortedVal] {
                x.append(item)
                map[sortedVal] = x
            }
            else {
                map[sortedVal] = [item]
            }
        }
        
        var finalList = [[String]]()
        for item in map.keys {
            if let y = map[item] {
                finalList.append(y)
            }
        }
        
        return finalList
    }
    
    static func myPow(val: Double, pow: Int) -> Double {
        var result = 1.0
        for _ in 0..<abs(pow) {
            result *= val
        }
        if pow < 0 {
            return 1/result
        }
        else {
            return result
        }
    }
    
    // Pending
    static func getSpiralMatrix(mat: [[Int]]) -> [Int] {
        if mat.isEmpty {
            return []
        }
        
        let length = mat.count
        var visited = Array(repeating: Array(repeating: false, count: mat[0].count), count: length)
        var result = [Int]()
        let start = 0
        let end = length - 1
        var x = start
        var y = start
        while true {
            
            if (x >= 0 && y >= 0) && (y + 1 <= end && x < end && visited[x][y + 1]) && (y < end && x + 1 <= end && visited[x + 1][y]) {
                break
            }
            
            if !visited[x][y] {
                visited[x][y] = true
                result.append(mat[x][y])
            }
            
            if x >= 0 && y >= 0 {
                if x == start && y < end {
                    if !visited[x][y + 1] {
                        y += 1
                    }
                    else if !visited[x + 1][y] {
                        x += 1
                    }
                }
                else if y == end && x < end {
                    if !visited[x + 1][y] {
                        x += 1
                    }
                    else if !visited[x][y - 1] {
                        y -= 1
                    }
                }
                else if x == end && y > start  {
                    if !visited[x][y - 1] {
                        y -= 1
                    }
                    else if !visited[x - 1][y] {
                        x -= 1
                    }
                }
                else if y == start && x > start {
                    if !visited[x - 1][y] {
                        x -= 1
                    }
                    else if !visited[x][y + 1] {
                        y += 1
                    }
                }
                else {
                    
                }
            }
        }
        
        return result
    }
    
    static func jumpGame(steps: [Int]) -> Bool {
        if steps.isEmpty {
            return false
        }
        
        let length = steps.count
        if length == 1 {
            return !(steps[0] > 0)
        }
        
        var visited = Array<Bool>(repeating: false, count: length)
        let queue = Queue<Int>()
        queue.enqueue(val: 0)
        visited[0] = true
        
        while !queue.isEmpty {
            let front = queue.dQueue()
            let val = steps[front]
            if val > 0 {
                let start = front + 1
                let end = front + val
                for index in start...end {
                    if index == length - 1 {
                        return true
                    }
                    else {
                        if steps[index] == 0 {
                            return false
                        }
                        else {
                            if !visited[index] {
                                visited[index] = true
                                queue.enqueue(val: index)
                            }
                        }
                    }
                }
            }
            else {
                return false
            }
        }
        return false
    }
}

// Easy
extension Problems {
    
    static func longestCommonPrefixHelper(small: String, str: String) -> String {
        var result = ""
        for index in 0..<small.count {
            if small[index] != str[index] {
                break
            }
            else {
                result += String(small[index])
            }
        }
        return result
    }
    
    static func longestCommonPrefix(list: [String]) -> String {
        if list.isEmpty {
            return ""
        }
        
        if list.count == 1 {
            return list[0]
        }
        
        var result = ""
        let sortedList = list.sorted { (x, y) -> Bool in
            x.count < y.count
        }
        
        result = sortedList[0]
        for index in 1..<sortedList.count {
            result = longestCommonPrefixHelper(small: result , str: sortedList[index])
        }
        return result
    }
    
    static func validateParantheses(str: String) -> Bool {
        if str.isEmpty {
            return false
        }
        
        let length = str.count
        if length == 1 {
            return false
        }
        
        let stack = Stack<Character>()
        let openingBraces = ["(", "{", "["]
        let closingBraces = [")", "}", "]"]

        for index in 0..<length {
            let item = str[index]
            let itemStr = String(item)
            if openingBraces.contains(itemStr) {
                stack.push(val: item)
            }
            else if closingBraces.contains(itemStr) {
                if !stack.isEmpty {
                    if let top = stack.top() {
                        switch top {
                        case "[":
                            if !(itemStr == "]") {
                                return false
                            }
                            else {
                                stack.pop()
                            }
                        case "(":
                            if !(itemStr == ")") {
                                return false
                            }
                            else {
                                stack.pop()
                            }
                        case "{":
                            if !(itemStr == "}") {
                                return false
                            }
                            else {
                                stack.pop()
                            }
                        default:
                            return false
                        }
                    }
                }
                else {
                    stack.push(val: item)
                }
            }
        }
        return stack.isEmpty
    }
    
    static func removeElement(list: inout [Int], val: Int) -> Int {
        if list.isEmpty {
            return 0
        }
        
        var index = 0
        while index < list.count {
            if list[index] == val {
                list.remove(at: index)
            }
            else {
                index += 1
            }
        }
        return list.count
    }
    
    // This fails for AAAAAAAAAAB, AAAAB so use KMP to achieve in O(n)
    static func strOfStr(str: String, niddle: String) -> Int {
        if str.isEmpty && niddle.isEmpty {
            return 0
        }
        
        let strLength = str.count
        let niddleLength = niddle.count
        
        if niddleLength > strLength {
            return -1
        }
        
        var index = -1

        for i in 0...(strLength - niddleLength) {
            var j = 0
            while j < niddleLength {
                if str[i + j] != niddle[j] {
                    break
                }
                j += 1
            }
            if j == niddleLength {
                index = i
            }
        }
        return index
    }
    
    static func calculateLSP(str: String) -> [Int] {
        if str.isEmpty {
            return []
        }
        
        let length = str.count
        var result = [Int](repeating: 0, count: length)
        var i = 1
        var l = 0
        result[0] = 0
        
        while i < length {
            if str[i] == str[l] {
                l += 1
                result[i] = l
                i += 1
            }
            else {
                if l > 0 {
                    l = result[l - 1]
                }
                else {
                    result[i] = 0
                    i += 1
                }
            }
        }
        return result
    }
    
    static func strOfStrV2(str: String, niddle: String) -> [Int] {
        if str.isEmpty && niddle.isEmpty {
            return []
        }
        
        let strLength = str.count
        let niddleLength = niddle.count
        
        if niddleLength > strLength {
            return []
        }
        
        var positions = [Int]()
        let lps = calculateLSP(str: niddle)
        
        var i = 0
        var j = 0
        while i < strLength {
            if j < niddleLength {
                if str[i] == niddle[j] {
                    j += 1
                    i += 1
                }
                if j == niddleLength {
                    positions.append(i - j)
                    j = lps[j - 1]
                }
                else {
                    if str[i] != niddle[j] {
                        if j != 0 {
                            j = lps[j - 1]
                        }
                        else {
                            i += 1
                        }
                    }
                }
            }
        }
        
        return positions
    }
    
    static func strOfStrV3(str: String, niddle: String) -> Int {
        if str.isEmpty && niddle.isEmpty {
            return 0
        }
        else if niddle.isEmpty {
            return 0
        }
        
        let strLength = str.count
        let niddleLength = niddle.count
        
        if niddleLength > strLength {
            return -1
        }
        
        let lps = calculateLSP(str: niddle)
        
        var i = 0
        var j = 0
        while i < strLength {
            if j < niddleLength {
                if str[i] == niddle[j] {
                    j += 1
                    i += 1
                }
                if j == niddleLength {
                    return (i - j)
                    // As we need to find the first position itself so commenting this
//                    j = lps[j - 1]
                }
                else {
                    if i >= 0  && j >= 0 && i < strLength && j < niddleLength && str[i] != niddle[j] {
                        if j != 0 {
                            j = lps[j - 1]
                        }
                        else {
                            i += 1
                        }
                    }
                }
            }
        }
        return -1
    }
    
    static func searchInsert(list: [Int], val: Int) -> Int {
        if list.isEmpty {
            return -1
        }
        
        let length = list.count
        let position = binarySearchGivePosition(list: list, start: 0, end: length - 1, element: val)
        if position == -1 {
            if let last = list.last, last < val {
                return length
            }
            else if list[0] > val {
                return 0
            }
            else {
                for index in 0..<length {
                    if list[index] > val {
                        return index
                    }
                }
            }
        }
        return position
    }
    
    static func maxSumSubArray(list: [Int]) -> Int {
        if list.isEmpty {
            return 0
        }
        
        var currSum = 0
        var maxSum = Int.min
        
        for item in list {
            currSum += item
            
            if maxSum < currSum {
                maxSum = currSum
            }
            
            if currSum < 0 {
                currSum = 0
            }
        }
        
        return maxSum
    }
}

struct ItemValue {
    let val: Int
    let depth: Int
}


// This is the interface that allows for creating nested lists.
// You should not implement it, or speculate about its implementation
class NestedInteger {
// Return true if this NestedInteger holds a single integer, rather than a nested list.
    public func isInteger() -> Bool {
        return false
    }
// Return the single integer that this NestedInteger holds, if it holds a single integer
// The result is undefined if this NestedInteger holds a nested list
    public func getInteger() -> Int {
        return 0
    }
// Set this NestedInteger to hold a single integer.
    public func setInteger(value: Int) {
        
    }
// Set this NestedInteger to hold a nested list and adds a nested integer to it.
    public func add(elem: NestedInteger) {
        
    }
// Return the nested list that this NestedInteger holds, if it holds a nested list
// The result is undefined if this NestedInteger holds a single integer
    public func getList() -> [NestedInteger] {
        return []
    }
}

// LinkedIn
extension Problems {
    
    static func hasOneLetterDifference(source: String, dest: String) -> Bool {
        if source.isEmpty || dest.isEmpty {
            return false
        }
        else if source.count != dest.count {
            return false
        }
        
        var counter = 0
        for i in 0..<source.count {
            let x = source[i]
            let y = dest[i]
            if x != y {
                counter += 1
            }
        }
        return counter == 1
    }
    
    static func wordLadder(list: [String], source: String, dest: String) -> Int {
        if list.isEmpty {
            return 0
        }
        
        if !list.contains(dest) {
            return 0
        }
        
        var items = list
        items.insert(source, at: 0)
        let length = items.count
        var sourceVal = source
        var visited = Array(repeating: false, count: length)
        let queue = Queue<String>()
        var map = [String: [String]]()
        for i in 1..<length {
            let item = items[i]
            var x = ""
            if hasOneLetterDifference(source: sourceVal, dest: dest) {
                x = dest
            }
            else if hasOneLetterDifference(source: sourceVal, dest: item) {
                x = item
            }
            
            if !x.isEmpty {
                if var listVal = map[sourceVal] {
                    listVal.append(x)
                    map[sourceVal] = listVal
                }
                else {
                    map[sourceVal] = [x]
                }
                sourceVal = x
                if x == dest {
                    break
                }
            }
        }
        
        queue.enqueue(val: items[0])
        visited[0] = true
        var counter = 1
        while !queue.isEmpty {
            let front = queue.dQueue()
            if let listVal = map[front] {
                for i in 0..<listVal.count {
                    let val = listVal[i]
                    if val == dest {
                        counter += 1
                        return counter
                    }
                    if let index = items.firstIndex(of: val), !visited[index] {
                        visited[index] = true
                        queue.enqueue(val: val)
                        counter += 1
                    }
                }
            }
        }
        
        return counter
    }
    
    static func canPlaceFlowers(list: [Int], n: Int) -> Bool {
        if list.isEmpty {
            return false
        }
        
        var listVal = list
        let length = listVal.count
        if length < n {
            return false
        }
    
        if length == 1 {
            if listVal[0] == 1 && n == 0 {
                return false
            }
            return listVal[0] == 1 ? false : true
        }
        
        var counter = 0
        for index in 0..<length {
            if index == 0 && listVal[index] == 0 && listVal[index + 1] == 0 {
                counter += 1
                listVal[index] = 1
            }
            else if index == length - 1 && listVal[index] == 0 && listVal[index - 1] == 0 {
                counter += 1
                listVal[index] = 1
            }
            else {
                if (index - 1 >= 0 && index + 1 < length) && (listVal[index] == 0 && listVal[index - 1] == 0 && listVal[index + 1] == 0) {
                    counter += 1
                    listVal[index] = 1
                }
            }
        }
        return counter >= n
    }
    
    static func depthSumInverse(_ nestedList: [NestedInteger]) -> Int {
        let maxDepth = findMaxDepth(nestedList)
        let weightedSum = getWeightedSum(nestedList, maxDepth)
        return weightedSum
    }
    
    private static func findMaxDepth(_ nestedList: [NestedInteger]) -> Int {
        var currentMaxDepth = 0
        for nestedInt in nestedList {
            if nestedInt.isInteger() {
                currentMaxDepth = max(currentMaxDepth, 1)
            } else {
                let currentDepth = findMaxDepth(nestedInt.getList())
                currentMaxDepth = max(currentMaxDepth, currentDepth + 1)
            }
        }
        return currentMaxDepth
    }
    
    private static func getWeightedSum(_ nestedList: [NestedInteger], _ depth: Int) -> Int {
        var currentSum = 0
        for nestedInt in nestedList {
            if nestedInt.isInteger() {
                currentSum += nestedInt.getInteger() * depth
            } else {
                currentSum += getWeightedSum(nestedInt.getList(), depth - 1)
            }
        }
        return currentSum
    }
    
    static func depthSum(list: [Any]) -> Int {
        return nestedListWeight(list: list, depth: 1)
    }
    
    static func nestedListWeight(list: [Any], depth: Int) -> Int {
        if list.isEmpty {
            return 0
        }
        
        var result = 0
        for item in list {
            if let val = item as? Int {
                result += val*depth
            }
            else if let val = item as? [Any] {
                result += nestedListWeight(list: val, depth: depth + 1)
            }
        }
        return result
    }
    
    static func evaluateReversePolish(list: [String]) -> Int {
        if list.isEmpty {
            return 0
        }
        
        let operators = ["+", "-", "*", "/"]
        
        let stack = Stack<Int>()
        for item in list {
            if let x = Int(item) {
                stack.push(val: x)
            }
            else {
                if operators.contains(item) {
                    let first = stack.pop()
                    let second = stack.pop()
                    switch item {
                    case "+":
                        stack.push(val: first + second)
                    case "-":
                        stack.push(val: second - first)
                    case "*":
                        stack.push(val: first * second)
                    case "/":
                        stack.push(val: second / first)
                    default:
                        print("None")
                    }
                }
            }
        }
        return !stack.isEmpty ? stack.pop() : -1
    }
    
    // Nice: DP
    static func maxProductSubArray(list: [Int]) -> Int {
        if list.isEmpty {
            return 0
        }
        
        let length = list.count
        var maxSoFar = list[0]
        var minSoFar = list[0]
        var maxProd = maxSoFar

        for i in 1..<length {
            let curr = list[i]
            let temp = max(curr, max(maxSoFar * curr, minSoFar * curr))
            minSoFar = min(curr, min(maxSoFar * curr, minSoFar * curr))
            maxSoFar = temp
            maxProd = max(maxSoFar, maxProd)
        }
        
        return maxProd
    }
    
    static func shortestWordDistance(list: [String], source: String, dest: String) -> Int {
        if list.isEmpty {
            return 0
        }
        
        let length = list.count
        if length == 1 {
            return 0
        }
        
        if length == 2 && list.contains(source) && list.contains(dest) {
            return 1
        }
        
        var start = -1
        var end = -1
        var dist = 0
        var ans = Int.max
        
        if list.contains(source) {
            for i in 0..<length {
                let val = list[i]
                if val == source {
                    if end != -1 {
                        dist = abs(i - end)
                        ans = min(dist, ans)
                    }
                    start = i
                }
                if val == dest {
                    if start != -1 {
                        dist = abs(i - start)
                        ans = min(dist, ans)
                    }
                    end = i
                }
            }
        }
        return ans
    }
    
    
    static func findSubSetsSet2(list: [Int], subset: inout [Int], index: Int, result: inout [[Int]]) {
        result.append(subset)
        for i in index..<list.count {
            subset.append(list[i])
            findSubSetsSet2(list: list, subset: &subset, index: index + 1, result: &result)
            subset.removeLast()
        }
    }
    
    static func findAllSubSetsSet2(list: [Int], numbreOfSets: Int) -> Bool {
        if list.isEmpty {
            return false
        }
        
        var subset = [Int]()
        var result = [[Int]]()
        
        findSubSetsSet2(list: list, subset: &subset, index: 0, result: &result)
        
        var temp = [Int]()
        for item in result {
            var sum = 0
            for val in item {
                sum += val
            }
            temp.append(sum)
        }
        
        let count = getDuplicateCount(list: &temp)
        
        return numbreOfSets == count
    }
    
    static func findSubSets(list: [Int], subset: inout Set<Int>, index: Int, result: inout Set<Set<Int>>) {
        result.insert(subset)
        for i in index..<list.count {
            subset.insert(list[i])
            findSubSets(list: list, subset: &subset, index: index + 1, result: &result)
            subset.remove(list[i])
        }
    }
    
    static func findAllSubSets(list: [Int], numbreOfSets: Int) -> (Set<Set<Int>>, hasSetsOfEqualSum: Bool)? {
        if list.isEmpty {
            return nil
        }
        
        var subset = Set<Int>()
        var result = Set<Set<Int>>()
        
        findSubSets(list: list, subset: &subset, index: 0, result: &result)
        
        var temp = [Int]()
        for item in result {
            var sum = 0
            for val in item {
                sum += val
            }
            temp.append(sum)
        }
        
        let count = getDuplicateCount(list: &temp)
        
        return (result, numbreOfSets >= count)
    }
    
    static func detectCycleInUndirectedGraph(currentNode: Int, adjencyList: [Int: [Int]], visited: inout [Bool], parent: Int) -> Bool {
        visited[currentNode] = true
        
        if let list = adjencyList[currentNode] {
            for item in list {
                if !visited[item] {
                    if detectCycleInUndirectedGraph(currentNode: item, adjencyList: adjencyList, visited: &visited, parent: currentNode) {
                        return true
                    }
                }
                else if item != parent {
                    return true
                }
            }
        }
        return false
    }
    
    static func validGraphTree(edges: [[Int]], n: Int) -> Bool {
        
        var adjencyMat = [Int: [Int]]()
        for item in edges {
            if var list = adjencyMat[item[0]] {
                list.append(item[1])
                adjencyMat[item[0]] = list
            }
            else {
                adjencyMat[item[0]] = [item[1]]
            }
        }
        
        var visited = Array<Bool>(repeating: false, count: n)
        
        if detectCycleInUndirectedGraph(currentNode: 0, adjencyList: adjencyMat, visited: &visited, parent: -1) {
            return false
        }
        
        for item in visited {
            if !item {
                return false
            }
        }
        
        return true
    }
    
    static func accountMerge(accounts: [[String]]) -> [[String]] {
        if accounts.isEmpty {
            return []
        }
        
        var emailSet = Set<String>()
        let accList = accounts.map { Account(list: $0) }
        let length = accounts.count
        var result = [[String]]()
        
        for i in 0..<length - 1 {
            let x = accList[i]
            for j in i + 1..<length {
                let y = accList[j]
                var vals = [String]()
                var emails = [String]()
                let common = x.emails.intersection(y.emails)
                if !common.isEmpty && common.count == 1 {
                    vals.append(x.name)
                    let union = x.emails.union(y.emails)
                    vals.append(contentsOf: union)
                    emails.append(contentsOf: union)
                }
                else {
                    vals.append(y.name)
                    vals.append(contentsOf: y.emails)
                    emails.append(contentsOf: y.emails)
                }
                if !vals.isEmpty && emailSet.intersection(vals).isEmpty {
                    result.append(vals)
                    emails.forEach{ emailSet.insert($0) }
                }
            }
        }
        
        return result
    }
    
    private static func getLeavesOfBinaryTreeHelper(root: inout TreeNode?) -> [Int] {
        var set = [Int]()
        if root?.left == nil && root?.right == nil {
            if let val = root?.value {
                set.append(val)
            }
            root = nil
            return set
        }
        var left = root?.left
        let leftSet = getLeavesOfBinaryTreeHelper(root: &left)
        var right = root?.right
        let rightSet = getLeavesOfBinaryTreeHelper(root: &right)
        return leftSet + rightSet
    }
    
    static func getLeavesOfBinaryTree(nodes: [Int]) -> [[Int]] {
        if nodes.isEmpty {
            return []
        }
        
        var result = [[Int]]()
        var treeRoot: TreeNode? = BinaryTree.createBinaryTree(nodes: nodes)
        while treeRoot != nil {
            let x = getLeavesOfBinaryTreeHelper(root: &treeRoot)
            result.append(x)
        }
        return result
    }
    
    static func isIsomorphic(_ s: String, _ t: String) -> Bool {
        if s.isEmpty || t.isEmpty {
            return false
        }
        
        let sLen = s.count
        let tLen = t.count

        if sLen != tLen {
            return false
        }
        
        var map = [Character: Character]()
        var set = Set<Character>()
        
        var j = 0
        var i = 0
        while i < sLen {
            if let val = map[s[i]] {
                if val != t[j] {
                    return false
                }
            }
            else {
                if !set.contains(t[j]) {
                    map[s[i]] = t[j]
                    set.insert(t[j])
                }
                else {
                    return false
                }
            }
            i += 1
            j += 1
        }
        
        return true
    }
    
    static private func markNeighboursNodeVisited(mat : inout [[Int]], visited : inout [[Bool]], x : Int, y : Int, m : Int, n : Int) {
        
        visited[x][y] = true
        
        var row = x - 1
        while row <= x + 1 && row < m {
            var col = y - 1
            while col <= y + 1 && col < n {
                if row >= 0 && col >= 0 && !visited[row][col] {
                    if mat[row][col] == 1 {
                        markNeighboursNodeVisited(mat: &mat, visited: &visited, x: row, y: col, m: m, n: n)
                        mat[row][col] = -mat[row][col]
                    }
                }
                col += 1
            }
            row += 1
        }
    }
        
    static func numIslands(_ grid: [[Character]]) -> Int {
        
        if grid.isEmpty {
            return 0
        }
        
        var result = 0
        let innerList = grid[0]
        let m = grid.count
        let n = innerList.count
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        var matVal = Array(repeating: Array(repeating: 0, count: n), count: m)
        
        for i in 0..<m {
            for j in 0..<n {
                if let val = Int(String(grid[i][j])), val == 1 {
                    matVal[i][j] = val
                }
            }
        }
        
        for i in 0..<m {
            for j in 0..<n {
                if matVal[i][j] == 1 {
                    result += 1
                    markNeighboursNodeVisited(mat: &matVal, visited: &visited, x: i, y: j, m: m, n: n)
                }
            }
        }
        return result
        
    }
    
    static func kSmallestPairs(_ nums1: [Int], _ nums2: [Int], _ k: Int) -> [[Int]] {
        if nums1.isEmpty || nums2.isEmpty {
            return []
        }
        
        let len1 = nums1.count
        let len2 = nums2.count
        
        var result = [[Int]]()
        var vals = [PairItem]()
        for i in 0..<len1 {
            for j in 0..<len2 {
                vals.append(PairItem([nums1[i], nums2[j]]))
            }
        }
        
        let heap = Heap<PairItem>(type: .minHeap, list: vals)
        
        for _ in 1...k {
            if let item = heap.extract() {
                result.append(item.list)
            }
        }
        
        return result
    }
    
    static func smallestLetterGreaterThanTargetHelper(letters: [Character], target: Character, start: Int, end: Int) -> Int {
        if start > end {
            return -1
        }
        
        let mid = (start + end)/2
        if mid >= 0 && mid + 1 <= end && letters[mid + 1] > target && letters[mid] <= target {
            return mid + 1
        }
        else if mid - 1 >= 0 && mid < end && letters[mid - 1] <= target && letters[mid] > target {
            return mid
        }
        else if mid >= 0 && mid < end && target < letters[mid] {
            return smallestLetterGreaterThanTargetHelper(letters: letters, target: target, start: start, end: mid - 1)
        }
        else {
            return smallestLetterGreaterThanTargetHelper(letters: letters, target: target, start: mid + 1, end: end)
        }
    }
    
    static func smallestLetterGreaterThanTarget(letters: [Character], target: Character) -> Character {
        if letters.isEmpty {
            return "a"
        }
        
        let start = 0
        let end = letters.count - 1
        if target < letters[start] {
            return letters[start]
        }
        let index = smallestLetterGreaterThanTargetHelper(letters: letters, target: target, start: start, end: end)
        let result = index != -1 ? letters[index] : letters[0]
        return result
    }
    
    static func isProductLessThan(target: Int, for list: [Int]) -> Bool {
        if list.isEmpty {
            return false
        }
        let product = list.reduce(1) { (val, curr) -> Int in
            return val * curr
        }
        return product < target
    }
    
    static func isProductEqualTo(target: Int, for list: [Int]) -> Bool {
        if list.isEmpty {
            return false
        }
        let product = list.reduce(1) { (val, curr) -> Int in
            return val * curr
        }
        return product == target
    }
    
    static func factorCombinationHelper(_ n: Int, _ start: Int, subset: inout Set<Int>, result: inout Set<Set<Int>>) {
        if start <= 1 {
            result.insert(subset)
            return
        }
        
        for i in start...n {
            if n % i == 0 {
                subset.insert(i)
                factorCombinationHelper(n / i, i, subset: &subset, result: &result)
                subset.remove(i)
            }
        }
    }
    
    static func factorCombination(target: Int) {
        var subset = Set<Int>()
        var result = Set<Set<Int>>()
        factorCombinationHelper(target, 2, subset: &subset, result: &result)
    }
    
    static func intToRomanSet2(_ num: Int) -> String {
        var result = ""
        if num >= 1 && num <= 3999 {
            var target = num
            let values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
            let symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
            for i in 0..<values.count {
                while values[i] <= target {
                    target -= values[i]
                    result += symbols[i]
                }
            }
        }
        return result
    }
    
    static func matrixMultiplication(mat1: [[Int]], mat2: [[Int]]) -> [[Int]] {
        if mat1.isEmpty {
            return mat2
        }
        else if mat2.isEmpty {
            return mat1
        }
        
        let m1 = mat1.count
        let n1 = mat1[0].count
        let m2 = mat2.count
        let n2 = mat2[0].count
            
        if n1 == m2 {
            var result = Array(repeating: Array(repeating: 0, count: n2), count: m1)
            for i in 0..<m1 {
                for l in 0..<n2 {
                    var sum = 0
                    var j = 0
                    for m in 0..<m2 {
                        let y = mat2[m][l]
                        let x = mat1[i][j]
                        sum += x*y
                        j += 1
                    }
                    result[i][l] = sum
                }
            }
            return result
        }
        
        return []
    }
    
    static func isPerfectSqaure(_ n: Int) -> Bool {
        if n < 1 {
            return false
        }
        
        if n == 1 {
            return true
        }
        
        var left = 1
        var right = n
        
        while left <= right {
            
            let mid = (left + right) / 2
            
            if mid * mid == n {
                return true
            }
            else if mid * mid < n {
                left = mid + 1
            }
            else {
                right = mid - 1
            }
        }
        
        return false
    }
    
    static func squareRoot(_ n: Int) -> Int {
        if n < 1 {
            return 0
        }
        
        if n == 1 {
            return 1
        }
        
        var left = 1
        var right = n/2
        
        while left <= right {
            
            let mid = (left + right) / 2
            let val = mid * mid
            if val < n {
                left = mid + 1
            }
            else if val > n {
                right = mid - 1
            }
            else {
                return mid
            }
        }
        
        return right
    }
    
    func isSymmetricTree(root: TreeNode?) -> Bool {
        if root == nil {
            return true
        }
        
        
        return false
    }
}

class TwoSum {

    /** Initialize your data structure here. */
    private var list = [Int]()
    
    init() {
        
    }
    
    /** Add the number to an internal data structure.. */
    func add(_ number: Int) {
        list.append(number)
    }
    
    /** Find if there exists any pair of numbers which sum is equal to the value. */
    func find(_ value: Int) -> Bool {
        if list.isEmpty {
            return false
        }
        
        let numbers = list.sorted()
        var start = 0
        var end = list.count - 1
        while start < end {
            if numbers[start] + numbers[end] == value {
                return true
            }
            else if numbers[start] + numbers[end] < value {
                start += 1
            }
            else {
                end -= 1
            }
        }
        return false
    }
}



struct PairItem: Equatable {
    let first: Int
    let second: Int
    init(_ list: [Int]) {
        if list.count > 1 {
            first = list[0]
            second = list[1]
        }
        else {
            first = -1
            second = -1
        }
    }
    
    var list: [Int] {
        return [first, second]
    }
}

extension PairItem: Comparable {
    static func < (lhs: PairItem, rhs: PairItem) -> Bool {
        return lhs.first + lhs.second <= rhs.first + rhs.second
    }
}

class SolBase {
    func rand7() -> Int {
        return Int.random(in: 1...7)
    }
}

class Solution : SolBase {
    func rand10() -> Int {
        let x = rand7()
        switch x {
        case 1, 2, 3:
            return x + 6
        default:
            return rand7()
        }
    }
}

struct Account {
    let name: String
    let emails: Set<String>
    init(list: [String]) {
        var set = Set<String>()
        name = list[0]
        for i in 1..<list.count {
            let item = list[i]
            set.insert(item)
        }
        emails = set
    }
}

extension Array where Element == Int {
    var stringVal: String {
        var val = ""
        for index in 0..<self.count {
            val += String(self[index])
        }
        return val
    }
}

extension Character {
    var alphabetAsciiVal: Int {
        return -1
    }
    
    var isAlphabet: Bool {
        if let val = self.asciiValue, self.isLetter, val >= 97 && val <= 122 {
            return true
        }
        return false
    }
    
}

extension Int {
    
    var isPrimeNumber: Bool {
        var counter = 2
        while counter <= self/2 {
            if self % counter == 0 {
                return false
            }
            counter += 1
        }
        return true
    }
    
}

