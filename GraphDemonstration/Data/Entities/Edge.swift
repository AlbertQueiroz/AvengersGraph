//
//  Edge.swift
//  GraphDemonstration
//
//  Created by Albert Rayneer on 10/06/22.
//

import Foundation

enum EdgeType {
    case directed
    case undirected
}

struct Edge<T> {
    let source: Vertex<T>
    let destination: Vertex<T>
}
