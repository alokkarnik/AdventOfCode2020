//
//  05.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 05/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Problem_05: Puzzle {
    let input: [String]

    init() {
        input = InputFileReader.readInput(id: "05")
    }

    func part1() -> String {
        guard let maxSeatID = getAllSeatIDs(input).max() else {
            return "Error finding the maximum Seat ID"
        }
        return "\(maxSeatID)"
    }

    func part2() -> String {
        let sortedSeatIDs = getAllSeatIDs(input).sorted()

        for (index, seatID) in sortedSeatIDs.enumerated() {
            if !(sortedSeatIDs[index + 1] == (seatID + 1)) {
                return "\(seatID + 1)"
            }
        }

        return "Error finding the missing Seat ID"
    }

    func parseSeat(char: Character, lowerBound: inout Int, upperBound: inout Int) {
        let difference = upperBound - lowerBound

        if char == "F" || char == "L" {
            upperBound -= difference / 2
        } else {
            lowerBound += difference / 2
        }
    }

    func getAllSeatIDs(_ boardingPasses: [String]) -> [Int] {
        var seatIDs = [Int]()

        for boardingPass in boardingPasses {
            var lowerSection = 0
            var upperSection = 128
            var leftmostSeat = 0
            var rightmostSeat = 8

            for char in String(boardingPass.prefix(7)) {
                parseSeat(char: char, lowerBound: &lowerSection, upperBound: &upperSection)
            }

            for char in String(boardingPass.suffix(3)) {
                parseSeat(char: char, lowerBound: &leftmostSeat, upperBound: &rightmostSeat)
            }

            let seatID = lowerSection * 8 + leftmostSeat
            seatIDs.append(seatID)
        }

        return seatIDs
    }
}
