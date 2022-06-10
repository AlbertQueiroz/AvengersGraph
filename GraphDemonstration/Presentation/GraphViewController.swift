//
//  ViewController.swift
//  GraphDemonstration
//
//  Created by Albert Rayneer on 10/06/22.
//

import UIKit

class GraphViewController: UIViewController {

    let graph = AdjacencyList<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        plotGraph()
    }

    private func plotGraph() {
        let spiderMan = graph.createVertex(data: "Spider Man")
        let ironMan = graph.createVertex(data: "Iron Man")
        let captainAmerica = graph.createVertex(data: "Captain America")
        let antMan = graph.createVertex(data: "Ant Man")
        let civilWar = graph.createVertex(data: "Civil War")
        let avengers = graph.createVertex(data: "Avengers")
        let thor = graph.createVertex(data: "Thor")
        let ragnarok = graph.createVertex(data: "Ragnarok")
        let hulk = graph.createVertex(data: "Hulk")

        graph.add(.undirected, from: spiderMan, to: ironMan)
        graph.add(.undirected, from: spiderMan, to: civilWar)
        graph.add(.undirected, from: spiderMan, to: avengers)
        graph.add(.undirected, from: ironMan, to: avengers)
        graph.add(.undirected, from: ironMan, to: civilWar)
        graph.add(.undirected, from: captainAmerica, to: civilWar)
        graph.add(.undirected, from: captainAmerica, to: avengers)
        graph.add(.undirected, from: captainAmerica, to: antMan)
        graph.add(.undirected, from: antMan, to: civilWar)
        graph.add(.undirected, from: antMan, to: avengers)
        graph.add(.undirected, from: thor, to: avengers)
        graph.add(.undirected, from: thor, to: ragnarok)
        graph.add(.undirected, from: hulk, to: avengers)
        graph.add(.undirected, from: hulk, to: ragnarok)

        print(graph)
    }
}
