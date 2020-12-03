//
//  03.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 03/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Problem_03: Puzzle {
    var input: [String]

    init() {
        input = InputFileReader.readInput(id: "03")
    }

    func part1() -> String {
        return String(countTrees(right: 3, down: 1))
    }

    func part2() -> String {
        let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
        let multipliedTrees = slopes.reduce(1) { (multipliedTrees: Int, slope: (right: Int, down: Int)) -> Int in
            multipliedTrees * countTrees(right: slope.right, down: slope.down)
        }
        return String(multipliedTrees)
    }

    func countTrees(right: Int, down: Int) -> Int {
        var numberOfTrees = 0
        var index = 0

        for i in stride(from: down, to: input.count, by: down) {
            let treeRow = Array(input[i])
            index = index + right

            if treeRow[index % treeRow.count] == "#" {
                numberOfTrees += 1
            }
        }
        return numberOfTrees
    }
}
