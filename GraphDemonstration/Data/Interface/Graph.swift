//
//  Graph.swift
//  GraphDemonstration
//
//  Created by Albert Rayneer on 10/06/22.
//

import Foundation

protocol Graph {

    associatedtype Element
    func createVertex(data: Element) -> Vertex<Element>
    func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>)
    func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>)
    func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>)
    func edges(from source: Vertex<Element>) -> [Edge<Element>]

}
