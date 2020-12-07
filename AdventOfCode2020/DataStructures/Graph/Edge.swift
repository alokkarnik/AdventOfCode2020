//
//  Edge.swift
//  AdventOfCode2020
//
//  Created by Alok Karnik on 07/12/20.
//  Copyright © 2020 Alok Karnik. All rights reserved.
//

import Foundation

enum EdgeType {
    case directed, undirected
}

struct Edge<T: Hashable> {
    public var source: Vertex<T>
    public var destination: Vertex<T>
    public var weight: Double?
}

extension Edge: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(source)
        hasher.combine(destination)
        hasher.combine(weight)
    }

    static func == (lhs: Edge<T>, rhs: Edge<T>) -> Bool {
        return lhs.source == rhs.source &&
            lhs.destination == rhs.destination &&
            lhs.weight == rhs.weight
    }
}
