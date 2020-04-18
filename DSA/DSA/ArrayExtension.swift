//
//  ArrayExtension.swift
//  DSA
//
//  Created by Nishit on 17/04/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation


extension Array {
    
    func swapValues<T>(first : inout T, second : inout T) {
        let temp = first
        first = second
        second = temp
    }
    
    func reverseArray(start : Int, end : Int) {
        var startVal = start
        var endVal = end
        
        while startVal < endVal {
            
            var val1 = self[startVal]
            var val2 = self[endVal]
            
            swapValues(first: &val1, second: &val2)
            
            startVal += 1
            endVal += 1
        }
    }
    
    func arrayRotation(distance : Int) {
        
        let start = 0
        let end = self.count - 1
        let dPos = distance - 1

        self.reverseArray(start: start, end: dPos)
        self.reverseArray(start: dPos + 1, end: end)
    }
    
    func binarySearch(list : [Int], element : Int, start : Int, end : Int) -> Int {
        
        if start > end {
            return -1
        }
        
        let mid = (start + end)/2
        
        if list[mid] == element {
            return mid
        }
        else {
            if element > list[mid] {
                return binarySearch(list: list, element: element, start: mid + 1, end: end)
            }
            else {
                return binarySearch(list: list, element: element, start: start, end: mid - 1)
            }
        }
    }
    
    func findPivot(list : [Int], start : Int, end : Int) -> Int {
        
        if start > end {
            return -1
        }
        
        let mid = (start + end)/2
        
        if list[mid] > list[mid + 1] {
            return mid
        }
        else {
            if list[mid] < list[mid + 1] {
                return findPivot(list: list, start: mid + 1, end: end)
            }
            else if list[mid - 1] < list[mid] {
                return findPivot(list: list, start: start, end: mid - 1)
            }
        }
        
        return -1
    }
    
    func searchElementInSortedRotatedArrayVer1(list : [Int], element : Int) -> Int {
        
        let start = 0
        let end = list.count - 1
        var index = -1
        let pivot = findPivot(list: list, start: start, end: end)
        
        if pivot != -1 || pivot < list.count {
            index = binarySearch(list: list, element: element, start: start, end: pivot)
            if index == -1 {
                index = binarySearch(list: list, element: element, start: pivot + 1, end: end)
            }
        }
        
        return index
    }
    
    func searchElementInSortedRotatedArrayVer2(list : [Int], element : Int, start : Int, end : Int) -> Int {
        
        if start > end {
            return -1
        }
        
        let mid = (start + end)/2
        
        if list[mid] == element {
            return mid
        }
        else {
            if list[start] <= list[mid] {
                if element >= list[start] && element <= list[mid] {
                    return searchElementInSortedRotatedArrayVer2(list: list, element: element, start: start, end: mid - 1)
                }
                else {
                    return searchElementInSortedRotatedArrayVer2(list: list, element: element, start: mid + 1, end: end)
                }
            }
            else {
                if element >= list[mid] && element <= list[end] {
                    return searchElementInSortedRotatedArrayVer2(list: list, element: element, start: mid + 1, end: end)
                }
            }
        }
        
        return -1
    }
}
