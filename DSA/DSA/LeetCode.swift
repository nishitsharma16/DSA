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

        if value == 0 {
            return result
        }
        
        let y = value % 10
        let x = value / 10
        for _ in 0..<x {
            result += "X"
        }
        
        if y >= 1 && y <= 3 {
            for _ in 0..<y {
                result += "I"
            }
        }
        
        switch y {
            case 4:
                result += "IV"
            case 5:
                result += "V"
            default:
                result += ""
        }
        
        if y > 5 && y < 9 {
            result += "V"
            for _ in 0..<y {
                result += "I"
            }
        }
        
        if y == 9 {
            result += "IX"
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
        if list[mid] == item && list[mid - 1] < list[mid] {
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
        if list[mid] == item && list[mid] < list[mid + 1] {
            return mid
        }
        else if item > list[mid] {
            return findFirstPosition(list: list, item: item, start: mid + 1, end: end)
        }
        else {
            return findFirstPosition(list: list, item: item, start: start, end: mid - 1)
        }
    }
    
    static func findFirstAndLastPositionOfItem(list: [Int], item: Int) -> (first: Int, last: Int) {
        if list.isEmpty {
            return (-1, -1)
        }
        
        let length = list.count
        let start = 0
        let end = length - 1
        
        let firstPosition = findFirstPosition(list: list, item: item, start: start, end: end)
        let lastPosition = findLastPosition(list: list, item: item, start: start, end: end)
        
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
