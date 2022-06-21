//
//  Graph.swift
//  GraphDemonstration
//
//  Created by Albert Rayneer on 20/06/22.
//

import SwiftGraph
import Foundation

public final class SubwayGraph {
    let graph: WeightedGraph<String, Int> = WeightedGraph<String, Int>(
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

    init() {
        addEdgesSouthLine()
        addEdgesWestLine()
        addEdgesEastLine()
        addEdgesVLTLine()
    }

    // MARK: Linha Sul
    func addEdgesSouthLine() {
        graph.addEdge(from: "LS - Xico da Silva", to: "José de Alencar", weight: 2)
        graph.addEdge(from: "José de Alencar", to: "São Benedito", weight: 2)
        graph.addEdge(from: "São Benedito", to: "Benfica", weight: 2)
        graph.addEdge(from: "Benfica", to: "Padre Cícero", weight: 2)
        graph.addEdge(from: "Padre Cícero", to: "Porangabussu", weight: 1)
        graph.addEdge(from: "Porangabussu", to: "Couto Fernandes", weight: 2)
        graph.addEdge(from: "Couto Fernandes", to: "Juscelino Kubitscheck", weight: 1)
        graph.addEdge(from: "Juscelino Kubitscheck", to: "Parangaba", weight: 2)
        graph.addEdge(from: "Parangaba", to: "Vila Pery", weight: 2)
        graph.addEdge(from: "Vila Pery", to: "Manoel Sátiro", weight: 2)
        graph.addEdge(from: "Manoel Sátiro", to: "Mondubim", weight: 2)
        graph.addEdge(from: "Mondubim", to: "Esperança", weight: 2)
        graph.addEdge(from: "Esperança", to: "Aracapé", weight: 2)
        graph.addEdge(from: "Aracapé", to: "Alto Alegre", weight: 2)
        graph.addEdge(from: "Alto Alegre", to: "Rachel de Queiroz", weight: 2)
        graph.addEdge(from: "Rachel de Queiroz", to: "Virgílio Távora", weight: 3)
        graph.addEdge(from: "Virgílio Távora", to: "Maracanaú", weight: 2)
        graph.addEdge(from: "Maracanaú", to: "Jereissati", weight: 1)
        graph.addEdge(from: "Jereissati", to: "Cartlito Benevides", weight: 2)
    }

    // MARK: Linha Oeste
    func addEdgesWestLine() {
        graph.addEdge(from: "LS - Xico da Silva", to: "LO -Moura Brasil", weight: 1)
        graph.addEdge(from: "LO -Moura Brasil", to: "Álvaro Weyne", weight: 7)
        graph.addEdge(from: "Álvaro Weyne", to: "Padre Andrade", weight: 4)
        graph.addEdge(from: "Padre Andrade", to: "Antônio Bezerra", weight: 3)
        graph.addEdge(from: "Antônio Bezerra", to: "São Miguel", weight: 7)
        graph.addEdge(from: "São Miguel", to: "Parque Albano", weight: 3)
        graph.addEdge(from: "Parque Albano", to: "Conjunto Ceará", weight: 3)
        graph.addEdge(from: "Conjunto Ceará", to: "Jurema", weight: 3)
        graph.addEdge(from: "Jurema", to: "Araturi", weight: 4)
        graph.addEdge(from: "Araturi", to: "Caucaia", weight: 6)
    }

    // Centro - Papicu - 15 min
    // MARK: Linha Leste
    func addEdgesEastLine() {
        graph.addEdge(from: "LS - Xico da Silva", to: "LL - Sé", weight: 3)
        graph.addEdge(from: "LL - Sé", to: "Colégio Militar", weight: 3)
        graph.addEdge(from: "Colégio Militar", to: "Luiza Távora", weight: 3)
        graph.addEdge(from: "Luiza Távora", to: "Nunes Valente", weight: 2)
        graph.addEdge(from: "Nunes Valente", to: "Leonardo Mota", weight: 1)
        graph.addEdge(from: "Leonardo Mota", to: "Papicu", weight: 3)
        graph.addEdge(from: "Papicu", to: "H.G.F", weight: 2)
        graph.addEdge(from: "H.G.F", to: "Cidade 2000", weight: 3)
        graph.addEdge(from: "Cidade 2000", to: "Bárbara de Alencar", weight: 6)
        graph.addEdge(from: "Bárbara de Alencar", to: "CEC", weight: 2)
        graph.addEdge(from: "CEC", to: "Edson Queiroz", weight: 2)
    }

    // MARK: VLT Parangaba-Mucuripe
    func addEdgesVLTLine() {
        graph.addEdge(from: "Parangaba", to: "VLT PM - Montese", weight: 3)
        graph.addEdge(from: "VLT PM - Montese", to: "Vila União", weight: 4)
        graph.addEdge(from: "Vila União", to: "Borges de Melo", weight: 4)
        graph.addEdge(from: "Borges de Melo", to: "S. João do Tauape", weight: 4)
        graph.addEdge(from: "S. João do Tauape", to: "Pontes Vieira", weight: 5)
        graph.addEdge(from: "Pontes Vieira", to: "Antônio Sales", weight: 3)
        graph.addEdge(from: "Antônio Sales", to: "Papicu", weight: 4)
        graph.addEdge(from: "Papicu", to: "Mucuripe", weight: 4)
        graph.addEdge(from: "Mucuripe", to: "Iate", weight: 3)
    }
}
