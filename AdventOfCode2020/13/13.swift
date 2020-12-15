//
//  13.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 13/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Problem_13: Puzzle {
    let input = InputFileReader.readInput(id: "13")

    func part1() -> String {
        let timeStamp = Int(input[0])!
        let busIDs = Array(input[1].components(separatedBy: ",")).filter { $0 != "x" }.map { Int($0)! }
        var minutesToWait = Int.max
        var targetBusID = 0

        for busID in busIDs {
            let timeSincelastDeparture = timeStamp % busID
            if busID - timeSincelastDeparture < minutesToWait {
                minutesToWait = busID - timeSincelastDeparture
                targetBusID = busID
            }
        }
        return "\(minutesToWait * targetBusID)"
    }

    func part2() -> String {
        return ""
    }
}
