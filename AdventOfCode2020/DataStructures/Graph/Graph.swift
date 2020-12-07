//
//  Graph.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 07/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

class Graph<T: Hashable> {
    public var adjacencyDict: [Vertex<T>: [Edge<T>]] = [:]
    public init() {}

    fileprivate func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        adjacencyDict[source]?.append(edge)
    }

    fileprivate func addUndirectedEdge(vertices: (Vertex<Element>, Vertex<Element>), weight: Double?) {
        let (source, destination) = vertices
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
}

extension Graph: Graphable {
    public typealias Element = T

    func createVertex(data: T) -> Vertex<T> {
        let vertex = Vertex(data: data)

        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []
        }

        return vertex
    }

    func add(_ type: EdgeType, from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
        switch type {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(vertices: (source, destination), weight: weight)
        }
    }

    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        guard let edges = adjacencyDict[source] else {
            return nil
        }

        for edge in edges {
            if edge.destination == destination {
                return edge.weight
            }
        }

        return nil
    }

    func edges(from source: Vertex<T>) -> [Edge<T>]? {
        return adjacencyDict[source]
    }

    func bfs(from source: Vertex<T>, destination: Vertex<T>) -> [Vertex<T>]? {
        var searchQueue = Queue<Vertex<T>>()
        searchQueue.enqueue(source)
        var nodesVisited = [Vertex<T>]()

        while let nextNode = searchQueue.dequeue() {
            if nextNode == destination {
                return nodesVisited
            }

            nodesVisited.append(nextNode)

            if let allEdges = edges(from: nextNode) {
                for edge in allEdges {
                    if !nodesVisited.contains(edge.destination) {
                        searchQueue.enqueue(edge.destination)
                    }
                }
            }
        }
        return nil
    }

    func dfs(from source: Vertex<T>) -> [Vertex<T>] {
        var stack = Stack<Vertex<T>>()
        var nodesVisited = [Vertex<T>]()

        stack.push(source)

        while !stack.isEmpty {
            let topElement = stack.pop()!
            nodesVisited.append(topElement)

            if let allEdges = edges(from: topElement) {
                for edge in allEdges {
                    if !nodesVisited.contains(edge.destination) {
                        stack.push(edge.destination)
                    }
                }
            }
        }

        return nodesVisited
    }

    func weight(of source: Vertex<T>) -> Double {
        var totalWeight: Double = 1

        if let allEdges = edges(from: source) {
            for edge in allEdges {
                let localWeight = weight(of: edge.destination)
                totalWeight += edge.weight! * (localWeight > 0 ? localWeight : 1)
            }
        }
        return totalWeight
    }

    var description: CustomStringConvertible {
        var result = ""
        for (vertex, edges) in adjacencyDict {
            var edgeString = ""
            for (index, edge) in edges.enumerated() {
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString)] \n")
        }
        return result
    }
}
