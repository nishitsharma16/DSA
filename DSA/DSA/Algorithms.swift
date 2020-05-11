//
//  Algorithms.swift
//  DSA
//
//  Created by Nishit on 10/05/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation

class Algorithms {
    
    func findWords(mat : [[Character]], visited : inout [[Bool]], x : Int, y : Int, str : inout String, list : [String], resultList : inout [String]) {
        
        let innerList = mat[0]
        let m = mat.count
        let n = innerList.count
        
        visited[x][y] = true
        str = str + String(mat[x][y])
        
        if list.contains(str) {
            resultList.append(str)
        }
        
        var row = x - 1
        var col = y - 1
        
        while row < x + 1 && row < m {
            while col < y + 1 && col < n {
                if row >= 0 && col >= 0 && !visited[row][col] {
                    findWords(mat: mat, visited: &visited, x: row, y: col, str: &str, list: list, resultList: &resultList)
                }
                col += 1
            }
            row += 1
        }
        
        str.remove(at: str.index(before: str.endIndex))
        visited[x][y] = false
    }
    
    func boogle(mat : [[Character]], strList : [String]) {
        if mat.isEmpty {
            return
        }
        
        var result = [String]()
        var string = ""
        let innerList = mat[0]
        let m = mat.count
        let n = innerList.count
        var visited = Array(repeating: Array(repeating: false, count: n), count: m)
        
        for i in 0..<m {
            for j in 0..<n {
                findWords(mat: mat, visited: &visited, x: i, y: j, str: &string, list: strList, resultList: &result)
            }
        }
    }
}
