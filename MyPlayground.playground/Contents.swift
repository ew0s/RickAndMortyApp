import Foundation

struct Index {
    let row: Int;
    let column: Int;
}

struct Node {
    let isUsed: Int
    let pathTo = ""
    let index: Index;
    let meigbourNodes: [Node]
}

let start
