//
//  LeetCode.swift
//  DSA
//
//  Created by Nishit on 11/06/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

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


