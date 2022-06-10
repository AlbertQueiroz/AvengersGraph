//
//  Vertex.swift
//  GraphDemonstration
//
//  Created by Albert Rayneer on 10/06/22.
//

import Foundation

struct Vertex<T> {
    let data: T
    let index: Int
}

extension Vertex: Hashable where T: Hashable {}
extension Vertex: Equatable where T: Equatable {}

extension Vertex: CustomStringConvertible {

    var description: String{
        return "\(index):\(data)"
    }

}
