//
//  ResultDijkstra.swift
//  GraphDemonstration
//
//  Created by Brena Amorim on 19/06/22.
//

import Foundation

// MARK: Model for Result
final class ResultDijkstra {
    public static var instance = ResultDijkstra()

    public var minimumTime: Int = 0
    public var route: [String] = []

    private init (){}

}
