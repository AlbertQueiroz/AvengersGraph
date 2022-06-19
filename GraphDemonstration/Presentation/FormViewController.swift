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

    private func createGraph() {}

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
