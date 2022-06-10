//
//  AdjacencyList.swift
//  GraphDemonstration
//
//  Created by Albert Rayneer on 10/06/22.
//

import Foundation

class AdjacencyList <T: Hashable>: Graph {

    private var adjancencies: [Vertex<T>: [Edge<T>]] = [:]

    init() {}

    func createVertex(data: T) -> Vertex<T> {

        let vertex = Vertex(data: data, index: adjancencies.count)
        adjancencies[vertex] = []
        return vertex

    }

    func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>) {

        let edge = Edge(source: source, destination: destination)
        adjancencies[source]?.append(edge)

    }


    func addUndirectedEdge(between source: Vertex<T>, and destination: Vertex<T>) {

        addDirectedEdge(from: source, to: destination)
        addDirectedEdge(from: destination, to: source)

    }

    func add(_ edge: EdgeType, from source: Vertex<T>, to destination: Vertex<T>) {

        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination)
        case .undirected:
            addUndirectedEdge(between: source, and: destination)
        }

    }

    func edges(from source: Vertex<T>) -> [Edge<T>] {
        return adjancencies[source] ?? []
    }

}

extension AdjacencyList: CustomStringConvertible {
    public var description: String {
        var result = ""
        for (vertex, edges) in adjancencies { // 1
            var edgeString = ""
            for (index, edge) in edges.enumerated() { // 2
                if index != edges.count - 1 {
                    edgeString.append("\(edge.destination), ")
                } else {
                    edgeString.append("\(edge.destination)")
                }
            }
            result.append("\(vertex) ---> [ \(edgeString) ]\n") // 3
        }
        return result
    }

}
