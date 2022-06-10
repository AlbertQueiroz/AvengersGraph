//
//  ViewController.swift
//  GraphDemonstration
//
//  Created by Albert Rayneer on 10/06/22.
//

import UIKit

class GraphViewController: UIViewController {

    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avengers_background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let graph = AdjacencyList<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        createGraph()
        plotGraph()
    }

    private func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImage.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }

    private func createGraph() {
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

    private func plotGraph() {
        let adjancencies = graph.adjancencies

        for (vertex, edge) in adjancencies {
            let circleX = CGFloat(24 + (arc4random() % 200))
            let circleY = CGFloat(24 + (arc4random() % 400))

            let circleView = CircleView(frame: CGRect(
                x: circleX,
                y: circleY,
                width: 50,
                height: 50
            ))

            view.addSubview(circleView)
        }
    }
}
