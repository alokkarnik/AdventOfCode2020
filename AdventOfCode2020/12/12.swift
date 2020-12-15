//
//  12.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 12/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

enum Direction: Character, CaseIterable {
    case north = "N"
    case east = "E"
    case south = "S"
    case west = "W"
}

class Ship {
    var currentDirection: Direction = .east
    var north = 0, south = 0, east = 0, west = 0
    var waypoint = Waypoint()

    func parseNavigationInstructions(_ instructions: [String]) {
        for eachInstruction in instructions {
            let char = eachInstruction.first!
            let num = Int(eachInstruction.dropFirst())!

            if ["L", "R"].contains(char) {
                turn(direction: char, angle: num)
            } else {
                if char == "F" {
                    move(direction: currentDirection, distance: num)
                } else {
                    move(direction: Direction(rawValue: char)!, distance: num)
                }
            }
        }
    }

    func parseNavigationInstructionsUsingWaypoint(_ instructions: [String]) {
        for eachInstruction in instructions {
            let char = eachInstruction.first!
            let num = Int(eachInstruction.dropFirst())!

            if ["L", "R"].contains(char) {
                waypoint.turn(direction: char, angle: num)
            } else {
                if char == "F" {
                    moveWithWaypoint(distance: num)
                } else {
                    waypoint.move(direction: Direction(rawValue: char)!, distance: num)
                }
            }
        }
    }

    func moveWithWaypoint(distance: Int) {
        if waypoint.y > 0 {
            north += waypoint.y * distance
        } else {
            south += abs(waypoint.y) * distance
        }

        if waypoint.x > 0 {
            east += waypoint.x * distance
        } else {
            west += abs(waypoint.x) * distance
        }
    }

    func move(direction: Direction, distance: Int) {
        switch direction {
        case Direction.north:
            north += distance
        case Direction.east:
            east += distance
        case Direction.south:
            south += distance
        case Direction.west:
            west += distance
        }
    }

    func turn(direction: Character, angle: Int) {
        var allDirections = Direction.allCases

        if direction == "L" {
            allDirections.reverse()
        }

        let firstIndex = allDirections.firstIndex(of: currentDirection)
        let firstSlice = allDirections[0 ..< firstIndex!]
        allDirections = Array(allDirections.dropFirst(firstIndex!))
        allDirections.append(contentsOf: firstSlice)

        let angleRemainder = angle / 90
        currentDirection = allDirections[angleRemainder]
    }

    func manhattanDistance() -> Int {
        return abs(north - south) + abs(east - west)
    }
}

class Waypoint {
    var x = 10
    var y = 1

    func move(direction: Direction, distance: Int) {
        switch direction {
        case Direction.north:
            y += distance
        case Direction.east:
            x += distance
        case Direction.south:
            y -= distance
        case Direction.west:
            x -= distance
        }
    }

    func turn(direction: Character, angle: Int) {
        var allQuadrants = [(+1, +1), (+1, -1), (-1, -1), (-1, +1)]

        if direction == "L" {
            allQuadrants.reverse()
        }

        let currentQuadrant = (x: x < 0 ? -1 : 1, y: y < 0 ? -1 : 1)
        var firstIndex = 0
        for (index, (x, y)) in allQuadrants.enumerated() {
            if x == currentQuadrant.x, y == currentQuadrant.y {
                firstIndex = index
            }
        }
        let firstSlice = allQuadrants[0 ..< firstIndex]
        allQuadrants = Array(allQuadrants.dropFirst(firstIndex))
        allQuadrants.append(contentsOf: firstSlice)

        let angleRemainder = angle / 90
        let expectedQuadrant: (x: Int, y: Int) = allQuadrants[angleRemainder]
        if angle == 90 || angle == 270 {
            swap(&x, &y)
        }
        if (x > 0 && expectedQuadrant.x < 0) || (x < 0 && expectedQuadrant.x > 0) {
            x *= -1
        }
        if (y > 0 && expectedQuadrant.y < 0) || (y < 0 && expectedQuadrant.y > 0) {
            y *= -1
        }
    }
}

class Problem_12: Puzzle {
    let instruction = InputFileReader.readInput(id: "12")

    func part1() -> String {
        let ship = Ship()
        ship.parseNavigationInstructions(instruction)
        return "\(ship.manhattanDistance())"
    }

    func part2() -> String {
        let ship = Ship()
        ship.parseNavigationInstructionsUsingWaypoint(instruction)
        return "\(ship.manhattanDistance())"
    }
}
