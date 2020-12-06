//
//  06.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 06/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Problem_06: Puzzle {
    var input = [[String]]()

    init() {
        input = parseAnswerGroupsFrom(answerGroupsString: InputFileReader.readRawInput(id: "06"))
    }

    func part1() -> String {
        var yesCount = 0

        for individualGroup in input {
            yesCount += Set(individualGroup.flatMap { $0 }).count
        }

        return "\(yesCount)"
    }

    func part2() -> String {
        var yesCount = 0

        for var individualGroup in input {
            var groupSet = Set(individualGroup.removeFirst())
            individualGroup.forEach { groupSet = groupSet.intersection(Set($0)) }
            yesCount += groupSet.count
        }

        return "\(yesCount)"
    }
}

extension Problem_06 {
    func parseAnswerGroupsFrom(answerGroupsString inputString: String) -> [[String]] {
        return inputString.components(separatedBy: "\n\n").map { $0.components(separatedBy: .whitespacesAndNewlines).filter { $0 != "" } }
    }
}
