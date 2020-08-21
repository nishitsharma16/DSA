//
//  DP.swift
//  DSA
//
//  Created by Nishit on 10/06/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class DynamicProgramming {
    
    // Top-down manner or Memoization
    static func findFibNumberSet1(n : Int, list : inout [Int]) -> Int {
        if list[n] == -1 {
            if n <= 1 {
                list[n] = n
            }
            else {
                list[n] = findFibNumberSet1(n: n - 1, list: &list) + findFibNumberSet1(n: n - 2, list: &list)
            }
        }
        return list[n]
    }
    
    // Bottom-up manner or Tabulation
    static func findFibNumberSet2(n : Int) -> Int {
        var list = [Int]()
        list[0] = 0
        list[1] = 1
        for index in 2...n {
            list[index] = list[index - 1] + list[index - 2]
        }
        return list[n]
    }
    
    static func fibNumberSet1(nVal : Int) -> Int {
        var list = Array<Int>(repeating: -1, count: nVal + 1)
        let result = findFibNumberSet1(n: nVal, list: &list)
        return result
    }
    
    func findnThUglyNumber(nval : Int) -> Int {
        return 0
    }
    
}
