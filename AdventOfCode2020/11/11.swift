//
//  11.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 11/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Problem_11: Puzzle {
    let input = InputFileReader.readInput(id: "11").map { Array($0) }

    func part1() -> String {
        return getSeatsWith(predictionFunction: getAdjacentSeats(row:col:seatMap:))
    }

    func part2() -> String {
        return getSeatsWith(predictionFunction: getFuckingDirectionaAdjacentSeats(row:col:seatMap:))
    }

    func getSeatsWith(predictionFunction: (Int, Int, [[Character]]) -> [Character]) -> String {
        var seatMap = input
        while true {
            var tempSeatMap = seatMap

            for i in 0 ..< seatMap.count {
                for j in 0 ..< seatMap[0].count {
                    let seat = seatMap[i][j]
                    if seat == "#", shouldVacateSeat(row: i, col: j, seatMap: seatMap, predictionFunction: predictionFunction) {
                        tempSeatMap[i][j] = "L"
                    } else if seat == "L", canOccupySeat(row: i, col: j, seatMap: seatMap, predictionFunction: predictionFunction) {
                        tempSeatMap[i][j] = "#"
                    }
                }
            }

            if tempSeatMap == seatMap {
                return "\(getOccupiedSeats(seatMap: tempSeatMap))"
            }
            seatMap = tempSeatMap
        }
    }
}

extension Problem_11 {
    func canOccupySeat(row: Int, col: Int, seatMap: [[Character]], predictionFunction: (Int, Int, [[Character]]) -> [Character]) -> Bool {
        let adjacentSeats = predictionFunction(row, col, seatMap)
        return !adjacentSeats.contains("#")
    }

    func shouldVacateSeat(row: Int, col: Int, seatMap: [[Character]], predictionFunction: (Int, Int, [[Character]]) -> [Character]) -> Bool {
        let adjacentSeats = predictionFunction(row, col, seatMap)
        return adjacentSeats.filter { $0 == "#" }.count >= 5
    }

    func getAdjacentSeats(row: Int, col: Int, seatMap: [[Character]]) -> [Character] {
        var adjacentSeats = [Character]()

        let minRow = row - 1 >= 0 ? row - 1 : 0
        let maxRow = row + 1 < seatMap.count ? row + 1 : row
        let minCol = col - 1 >= 0 ? col - 1 : 0
        let maxCol = col + 1 < seatMap[0].count ? col + 1 : col

        for i in minRow ... maxRow {
            for j in minCol ... maxCol {
                if !(i == row && j == col) {
                    adjacentSeats.append(seatMap[i][j])
                }
            }
        }

        return adjacentSeats
    }

    func getFuckingDirectionaAdjacentSeats(row: Int, col: Int, seatMap: [[Character]]) -> [Character] {
        var topLeft: Character? = ".", top: Character? = ".", topRight: Character? = ".", left: Character? = ".", right: Character? = ".", bottomLeft: Character? = ".", bottom: Character? = ".", bottomRight: Character? = "."
        let limit = max(seatMap.count, seatMap[0].count)

        for i in 1 ... limit {
            // top
            if topLeft == "." {
                topLeft = getSeat(row: row - i, col: col - i, seatMap: seatMap)
            }
            if top == "." {
                top = getSeat(row: row - i, col: col, seatMap: seatMap)
            }

            if topRight == "." {
                topRight = getSeat(row: row - i, col: col + i, seatMap: seatMap)
            }

            // middle
            if left == "." {
                left = getSeat(row: row, col: col - i, seatMap: seatMap)
            }

            if right == "." {
                right = getSeat(row: row, col: col + i, seatMap: seatMap)
            }

            // bottom
            if bottomLeft == "." {
                bottomLeft = getSeat(row: row + i, col: col - i, seatMap: seatMap)
            }
            if bottom == "." {
                bottom = getSeat(row: row + i, col: col, seatMap: seatMap)
            }
            if bottomRight == "." {
                bottomRight = getSeat(row: row + i, col: col + i, seatMap: seatMap)
            }
        }
        return [topLeft, top, topRight, left, right, bottomLeft, bottom, bottomRight].compactMap { $0 }
    }

    func getSeat(row: Int, col: Int, seatMap: [[Character]]) -> Character? {
        if row < 0 || row > seatMap.count - 1 || col < 0 || col > seatMap[0].count - 1 {
            return nil
        }

        return seatMap[row][col]
    }

    func getOccupiedSeats(seatMap: [[Character]]) -> Int {
        return seatMap.flatMap { $0 }.filter { $0 == "#" }.count
    }

    func printMap(seatMap: [[Character]]) {
        for each in seatMap {
            print(String(each))
        }
    }
}
