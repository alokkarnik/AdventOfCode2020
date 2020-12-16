//
//  16.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 16/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Problem_16: Puzzle {
    let input = InputFileReader.readInput(id: "16")

    func part1() -> String {
        let sanitizedInput = parse(input: input)
        let validNumbers = validNumbersFrom(rules: sanitizedInput["rules"] as! [String: Set<Int>])

        return "\(getErrorScanningRate(validNumbers: validNumbers, tickets: sanitizedInput["otherTickets"] as! [[Int]]))"
    }

    func part2() -> String {
        let sanitizedInput = parse(input: input)
        let validNumbers = validNumbersFrom(rules: sanitizedInput["rules"] as! [String: Set<Int>])
        let validTickets = getValidTickets(validNumbers: validNumbers, tickets: sanitizedInput["otherTickets"] as! [[Int]])

        return "\(solvePart2(rules: sanitizedInput["rules"] as! [String: Set<Int>], validTickets: validTickets, myTicket: sanitizedInput["myTicket"] as! [Int]))"
    }

    func validNumbersFrom(rules: [String: Set<Int>]) -> Set<Int> {
        var validNumbers = Set<Int>()

        for rule in rules {
            validNumbers = validNumbers.union(rule.value)
        }
        return validNumbers
    }

    func getErrorScanningRate(validNumbers: Set<Int>, tickets: [[Int]]) -> Int {
        var errorScanningRate = 0

        for ticket in tickets {
            let ticketNumbers = Set(ticket.map { $0 })
            if ticketNumbers.intersection(validNumbers).count != ticketNumbers.count {
                errorScanningRate = ticketNumbers.subtracting(validNumbers).reduce(errorScanningRate, +)
            }
        }
        return errorScanningRate
    }

    func getValidTickets(validNumbers: Set<Int>, tickets: [[Int]]) -> [[Int]] {
        var validTickets = [[Int]]()

        for ticket in tickets {
            let ticketNumbers = Set(ticket.map { $0 })
            if ticketNumbers.intersection(validNumbers).count == ticketNumbers.count {
                validTickets.append(ticket)
            }
        }
        return validTickets
    }

    // 🤷🏻‍♀️
    func solvePart2(rules: [String: Set<Int>], validTickets: [[Int]], myTicket: [Int]) -> Int {
        var mySanitizedTicket = [String: Int]()

        var indexedNumbers = [Int: [Int]]()

        for i in 0 ..< validTickets[0].count {
            var nums = [Int]()
            for each in validTickets {
                nums.append(each[i])
            }
            indexedNumbers[i] = nums
        }

        var tempIndexedNumbers = indexedNumbers
        while tempIndexedNumbers.count != 0 {
            for rule in rules {
                var validCount = 0
                var ruleName = ""
                var fieldIndex = 0
                for eachIndex in tempIndexedNumbers {
                    if Set(eachIndex.value.map { $0 }).intersection(rule.value.map { $0 }).count == Set(eachIndex.value.map { $0 }).count {
                        validCount += 1
                        ruleName = rule.key
                        fieldIndex = Int(eachIndex.key)
                    }
                }

                if validCount == 1 {
                    mySanitizedTicket[ruleName] = fieldIndex
                    tempIndexedNumbers[fieldIndex] = nil
                }
            }
        }

        var myMultiplication = 1

        for eachRule in mySanitizedTicket {
            if eachRule.key.contains("departure") {
                myMultiplication *= myTicket[eachRule.value]
            }
        }

        return myMultiplication
    }
}

extension Problem_16 {
    // parsing

    func parse(rules: [String]) -> [[String]] {
        var parsedRules = [[String]]()
        for rule in rules {
            parsedRules.append(rule.components(separatedBy: ":").flatMap { $0.components(separatedBy: " or ") }.flatMap { $0.components(separatedBy: "-") }.compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines) })
        }

        return parsedRules
    }

    func parse(tickets: [String]) -> [[Int]] {
        var parsedTickets = [[Int]]()

        for ticket in tickets {
            let temp: [Int] = ticket.components(separatedBy: ",").map { Int($0)! }
            parsedTickets.append(temp)
        }

        return parsedTickets
    }

    func parse(input: [String]) -> [String: Any] {
        var sanitizedInput = [String: Any]()
        let myTicketIDX = input.firstIndex(of: "your ticket:")!
        let rules = parse(rules: Array(input[0 ..< myTicketIDX]))

        let myTicket = input[myTicketIDX + 1].components(separatedBy: ",").map { Int($0)! }

        let otherTicketsIDX = input.firstIndex(of: "nearby tickets:")!
        let otherTickets = parse(tickets: Array(input[otherTicketsIDX + 1 ..< input.count]))

        var sanitizedRules = [String: Set<Int>]()

        for rule in rules {
            var validNumbers = Set<Int>()
            for i in Int(rule[1])! ... Int(rule[2])! {
                validNumbers.insert(i)
            }

            for i in Int(rule[3])! ... Int(rule[4])! {
                validNumbers.insert(i)
            }

            sanitizedRules[rule[0]] = validNumbers
        }

        sanitizedInput["rules"] = sanitizedRules
        sanitizedInput["myTicket"] = myTicket
        sanitizedInput["otherTickets"] = otherTickets

        return sanitizedInput
    }
}
