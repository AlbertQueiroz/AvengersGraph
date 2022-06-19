//
//  ViewController.swift
//  GraphDemonstration
//
//  Created by Albert Rayneer on 10/06/22.
//

import UIKit
import SwiftGraph

class FormViewController: UIViewController {

    private let subwayGraph: WeightedGraph<String, Int> = WeightedGraph<String, Int>(
        vertices: [
        "LS - Xico da Silva",
        "José de Alencar",
        "São Benedito",
        "Benfica",
        "Padre Cícero",
        "Porangabussu",
        "Couto Fernandes",
        "Juscelino Kubitscheck",
        "Parangaba",
        "Vila Pery",
        "Manoel Sátiro",
        "Mondubim",
        "Esperança",
        "Aracapé",
        "Alto Alegre",
        "Rachel de Queiroz",
        "Virgílio Távora",
        "Maracanaú",
        "Jereissati",
        "Cartlito Benevides",
        "LO -Moura Brasil",
        "Álvaro Weyne",
        "Padre Andrade",
        "Antônio Bezerra",
        "São Miguel",
        "Parque Albano",
        "Conjunto Ceará",
        "Jurema",
        "Araturi",
        "Caucaia",
        "VLT PM - Montese",
        "Vila União",
        "Borges de Melo",
        "S. João do Tauape",
        "Pontes Vieira",
        "Antônio Sales",
        "Papicu",
        "Mucuripe",
        "Iate",
        "LL - Sé",
        "Colégio Militar",
        "Luiza Távora",
        "Nunes Valente",
        "Leonardo Mota",
        "Papicu",
        "H.G.F",
        "Cidade 2000",
        "Bárbara de Alencar",
        "CEC",
        "Edson Queiroz"
    ])

    private lazy var headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MetroFortal")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var indicatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Estação:"
        return label
    }()

    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private let graph = AdjacencyList<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupComponents()
        createGraph()
        plotGraph()
        dijkstra(root: "Porangabussu", destination: "Virgílio Távora")
    }

    private func setupComponents() {
        setupNavigation()
        setupHeaderImage()
        setupIndicatorLabel()
        setupPickerView()
    }


    @objc private func nextTapped() {
        navigationController?.pushViewController(FormViewController(), animated: true)
    }

    private func createGraph() {
        addEdgesVLTLine()
        addEdgesWestLine()
        addEdgesEastLine()
        addEdgesSouthLine()
    }

    private func plotGraph() {}
}

extension FormViewController {

    private func setupNavigation() {
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Ponto de Partida"
        setupNextButton()
    }

    private func setupNextButton() {
        let next = UIBarButtonItem(
            title: "Próximo",
            style: .plain,
            target: self, action: #selector(nextTapped)
        )
        navigationItem.rightBarButtonItem = next
    }

    private func setupHeaderImage() {
        view.addSubview(headerImage)
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerImage.heightAnchor.constraint(equalTo: headerImage.widthAnchor)
        ])
    }

    private func setupIndicatorLabel() {
        view.addSubview(indicatorLabel)
        NSLayoutConstraint.activate([
            indicatorLabel.topAnchor.constraint(equalTo: headerImage.bottomAnchor, constant: 24),
            indicatorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            indicatorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24)
        ])
    }

    private func setupPickerView() {
        view.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.dataSource = self
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: indicatorLabel.bottomAnchor),
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pickerView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension FormViewController: UIPickerViewDelegate {}

extension FormViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subwayGraph.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subwayGraph[row]
    }

}

// MARK: EDGES
extension FormViewController {
    // MARK: Linha Sul
    func addEdgesSouthLine() {
        subwayGraph.addEdge(from: "LS - Xico da Silva", to: "José de Alencar", weight: 2)
        subwayGraph.addEdge(from: "José de Alencar", to: "São Benedito", weight: 2)
        subwayGraph.addEdge(from: "São Benedito", to: "Benfica", weight: 2)
        subwayGraph.addEdge(from: "Benfica", to: "Padre Cícero", weight: 2)
        subwayGraph.addEdge(from: "Padre Cícero", to: "Porangabussu", weight: 1)
        subwayGraph.addEdge(from: "Porangabussu", to: "Couto Fernandes", weight: 2)
        subwayGraph.addEdge(from: "Couto Fernandes", to: "Juscelino Kubitscheck", weight: 1)
        subwayGraph.addEdge(from: "Juscelino Kubitscheck", to: "Parangaba", weight: 2)
        subwayGraph.addEdge(from: "Parangaba", to: "Vila Pery", weight: 2)
        subwayGraph.addEdge(from: "Vila Pery", to: "Manoel Sátiro", weight: 2)
        subwayGraph.addEdge(from: "Manoel Sátiro", to: "Mondubim", weight: 2)
        subwayGraph.addEdge(from: "Mondubim", to: "Esperança", weight: 2)
        subwayGraph.addEdge(from: "Esperança", to: "Aracapé", weight: 2)
        subwayGraph.addEdge(from: "Aracapé", to: "Alto Alegre", weight: 2)
        subwayGraph.addEdge(from: "Alto Alegre", to: "Rachel de Queiroz", weight: 2)
        subwayGraph.addEdge(from: "Rachel de Queiroz", to: "Virgílio Távora", weight: 3)
        subwayGraph.addEdge(from: "Virgílio Távora", to: "Maracanaú", weight: 2)
        subwayGraph.addEdge(from: "Maracanaú", to: "Jereissati", weight: 1)
        subwayGraph.addEdge(from: "Jereissati", to: "Cartlito Benevides", weight: 2)
    }

    // MARK: Linha Oeste
    func addEdgesWestLine() {
        subwayGraph.addEdge(from: "LS - Xico da Silva", to: "LO -Moura Brasil", weight: 1)
        subwayGraph.addEdge(from: "LO -Moura Brasil", to: "Álvaro Weyne", weight: 7)
        subwayGraph.addEdge(from: "Álvaro Weyne", to: "Padre Andrade", weight: 4)
        subwayGraph.addEdge(from: "Padre Andrade", to: "Antônio Bezerra", weight: 3)
        subwayGraph.addEdge(from: "Antônio Bezerra", to: "São Miguel", weight: 7)
        subwayGraph.addEdge(from: "São Miguel", to: "Parque Albano", weight: 3)
        subwayGraph.addEdge(from: "Parque Albano", to: "Conjunto Ceará", weight: 3)
        subwayGraph.addEdge(from: "Conjunto Ceará", to: "Jurema", weight: 3)
        subwayGraph.addEdge(from: "Jurema", to: "Araturi", weight: 4)
        subwayGraph.addEdge(from: "Araturi", to: "Caucaia", weight: 6)
    }

    // Centro - Papicu - 15 min
    // MARK: Linha Leste
    func addEdgesEastLine() {
        subwayGraph.addEdge(from: "LS - Xico da Silva", to: "LL - Sé", weight: 3)
        subwayGraph.addEdge(from: "LL - Sé", to: "Colégio Militar", weight: 3)
        subwayGraph.addEdge(from: "Colégio Militar", to: "Luiza Távora", weight: 3)
        subwayGraph.addEdge(from: "Luiza Távora", to: "Nunes Valente", weight: 2)
        subwayGraph.addEdge(from: "Nunes Valente", to: "Leonardo Mota", weight: 1)
        subwayGraph.addEdge(from: "Leonardo Mota", to: "Papicu", weight: 3)
        subwayGraph.addEdge(from: "Papicu", to: "H.G.F", weight: 2)
        subwayGraph.addEdge(from: "H.G.F", to: "Cidade 2000", weight: 3)
        subwayGraph.addEdge(from: "Cidade 2000", to: "Bárbara de Alencar", weight: 6)
        subwayGraph.addEdge(from: "Bárbara de Alencar", to: "CEC", weight: 2)
        subwayGraph.addEdge(from: "CEC", to: "Edson Queiroz", weight: 2)
    }

    // MARK: VLT Parangaba-Mucuripe
    func addEdgesVLTLine() {
        subwayGraph.addEdge(from: "Parangaba", to: "VLT PM - Montese", weight: 3)
        subwayGraph.addEdge(from: "VLT PM - Montese", to: "Vila União", weight: 4)
        subwayGraph.addEdge(from: "Vila União", to: "Borges de Melo", weight: 4)
        subwayGraph.addEdge(from: "Borges de Melo", to: "S. João do Tauape", weight: 4)
        subwayGraph.addEdge(from: "S. João do Tauape", to: "Pontes Vieira", weight: 5)
        subwayGraph.addEdge(from: "Pontes Vieira", to: "Antônio Sales", weight: 3)
        subwayGraph.addEdge(from: "Antônio Sales", to: "Papicu", weight: 4)
        subwayGraph.addEdge(from: "Papicu", to: "Mucuripe", weight: 4)
        subwayGraph.addEdge(from: "Mucuripe", to: "Iate", weight: 3)
    }
}

// MARK: SETUP GRAPH
extension FormViewController {
    func dijkstra(root: String, destination: String) -> BestWay {
        let (weights, pathDict) = subwayGraph.dijkstra(root: root, startDistance: 0)
        let weightFromRootToVertice: [String: Int?] = distanceArrayToVertexDict(distances: weights,
                                                                                  graph: subwayGraph)
 
        
        let minimumTimeResult = weightFromRootToVertice[destination] as? Int
        let pathResult: [WeightedEdge<Int>] = pathDictToPath(from: subwayGraph.indexOfVertex(root)!, to: subwayGraph.indexOfVertex(destination)!, pathDict: pathDict)
        let stops: [String] = subwayGraph.edgesToVertices(edges: pathResult)

        
        let result = BestWay(minimumTime: minimumTimeResult!, route: stops)
        return result
    }
}

// MARK: Model for Result
struct BestWay {
    let minimumTime: Int
    let route: [String]
}
