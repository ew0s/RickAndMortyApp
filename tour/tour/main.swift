//
//  main.swift
//  tour
//
//  Created by Егор Савковский on 10.05.2021.
//

import Foundation

import Foundation

struct Index {
    var row: Int;
    var column: Int;
}

struct Node {
    var isUsed: Int = 1
    var pathTo = ""
    var index: Index = Index(row: 0, column: 0);
    var neigbourNodes: [Node] = []
    
    init() {}
}

let startX, startY: Int
let finishX, finishY: Int

func getNeigbourVertexes(with matrix: [[Node]], and currentIndex: Index) -> [[Node]] {
    
    let row = currentIndex.row
    let column = currentIndex.column
    var newMatrix = matrix
    
    var upIndex =       Index(row: row - 1, column: column)
    var downIndex =     Index(row: row + 1, column: column)
    var leftIndex =     Index(row: row, column: column - 1)
    var rightIndex =    Index(row: row, column: column + 1)
    
    if (row == 0) {
        upIndex.row = matrix.count - 1
    } else if (row == matrix.count - 1) {
        downIndex.row = 0
    }
    
    if (column == 0) {
        leftIndex.column = matrix[row].count - 1
    } else if (column == matrix[row].count - 1) {
        rightIndex.column = 0
    }
    
    newMatrix[currentIndex.row][currentIndex.column].neigbourNodes = [ matrix[upIndex.row][upIndex.column],
        matrix[downIndex.row][downIndex.column],
        matrix[leftIndex.row][leftIndex.column],
        matrix[rightIndex.row][rightIndex.column]
    ]
    
    return newMatrix
}

func readMatrix(height: Int, width: Int) -> [[Node]] {
    
    var matrix = [[Node]](repeating: [Node](repeating: Node(), count: width), count: height)
    for row in 0..<height {
        for column in 0..<width {
            matrix[row][column].isUsed = Int(readLine()!)!
            matrix[row][column].index = Index(row: row, column: column)
            matrix = getNeigbourVertexes(with: matrix, and: Index(row: row, column: column))
        }
    }
    
    return matrix
}

func main() {
    let height = Int(readLine() ?? "0")
    let width = Int(readLine() ?? "0")
    let matrix = readMatrix(height: height!, width: width!)
    
    for nodes in matrix {
        for node in nodes {
            print(node.isUsed, separator: " ", terminator: " ")
        }
        print("\n")
    }
}

main()
