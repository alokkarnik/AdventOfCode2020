//
//  07.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 07/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

struct Problem_07: Puzzle {
    var inputGraph = Graph<String>()

    init() {
        inputGraph = parse(rawInput: InputFileReader.readInput(id: "07"))
    }

    func part1() -> String {
        var count = 0
        let vertexToFind = Vertex(data: "shiny gold")
        for vertex in inputGraph.adjacencyDict.keys {
            if inputGraph.bfs(from: vertex, destination: vertexToFind) != nil {
                count += 1
            }
        }
        return "\(count - 1)"
    }

    func part2() -> String {
        let sourceVertex = Vertex(data: "shiny gold")
        let depth = inputGraph.weight(of: sourceVertex) - 1

        return "\(depth)"
    }
}

extension Problem_07 {
    func parse(rawInput: [String]) -> Graph<String> {
        let bagGraph = Graph<String>()

        let parentColorRegex = try! NSRegularExpression(pattern: "(.+?) bags")
        let childColorRegex = try! NSRegularExpression(pattern: "(\\d+) (.+?) bag")

        for line in rawInput {
            let range = NSRange(location: 0, length: line.utf8.count)
            let parentColorMatch = parentColorRegex.matches(in: line, options: [], range: range)
            let childColorsMatch = childColorRegex.matches(in: line, options: [], range: range)

            let parentColor = parentColorMatch.map { String(line[Range($0.range, in: line)!]) }[0].replacingOccurrences(of: "bags", with: "").trimmingCharacters(in: .whitespacesAndNewlines)

            let childColors = childColorsMatch.flatMap {
                String(line[Range($0.range, in: line)!].replacingOccurrences(of: "bag", with: "")).trimmingCharacters(in: .whitespacesAndNewlines).split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
            }

            for i in stride(from: 0, to: childColors.count, by: 2) {
                let childBagQuantity = Int(childColors[i])!
                let childBagColor = String(childColors[i + 1])

                bagGraph.add(.directed,
                             from: bagGraph.createVertex(data: parentColor),
                             to: bagGraph.createVertex(data: childBagColor),
                             weight: Double(childBagQuantity))
            }
        }
        return bagGraph
    }
}
