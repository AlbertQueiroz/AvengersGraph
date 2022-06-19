//
//  ViewController.swift
//  GraphDemonstration
//
//  Created by Albert Rayneer on 10/06/22.
//

import UIKit
import SwiftGraph


class FormViewController: UIViewController {
    enum FormType {
        case from
        case to
        case result
    }

    private let type: FormType

    private let formData = FormData.instance

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
        label.text = type == .result ? "Paradas:" : "Estação:"
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()

    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = formData.result
        label.numberOfLines = 0
        return label
    }()

    private var currentPickerValue: String?
    private let graph = AdjacencyList<String>()

    init(type: FormType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTitle()
        setupComponents()
        createGraph()
        plotGraph()
    }

    private func setupComponents() {
        setupNavigation()
        setupHeaderImage()
        setupIndicatorLabel()
        setupPickerViewIfNeeded()
        setupResultLabelIfNeeded()
    }

    @objc private func nextTapped() {
        var nextType: FormType
        switch type {
        case .from:
            nextType = .to
            formData.from = currentPickerValue
        case .to:
            nextType = .result
            formData.to = currentPickerValue
        case .result:
            navigationController?.popToRootViewController(animated: true)
            return
        }
        navigationController?.pushViewController(
            FormViewController(type: nextType),
            animated: true
        )
    }

    private func createGraph() {}

    private func plotGraph() {}
}

extension FormViewController {

    private func setupNavigation() {
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        setupNextButton()
    }

    private func setTitle() {
        switch type {
        case .from:
            title = "Ponto de Partida"
        case .to:
            title = "Ponto de Chegada"
        case .result:
            title = "Melhor Caminho"
        }
    }

    private func setupNextButton() {
        let next = UIBarButtonItem(
            title: type == .result ? "Finalizar" : "Próximo",
            style: .plain,
            target: self, action: #selector(nextTapped)
        )
        navigationItem.rightBarButtonItem = next
    }

    private func setupHeaderImage() {
        view.addSubview(headerImage)
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerImage.heightAnchor.constraint(equalTo: headerImage.widthAnchor)
        ])
    }

    private func setupIndicatorLabel() {
        view.addSubview(indicatorLabel)
        NSLayoutConstraint.activate([
            indicatorLabel.topAnchor.constraint(equalTo: headerImage.bottomAnchor),
            indicatorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            indicatorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    private func setupPickerViewIfNeeded() {
        guard type != .result else { return }
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

    private func setupResultLabelIfNeeded() {
        guard type == .result else { return }
        view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: indicatorLabel.bottomAnchor),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
}

extension FormViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentPickerValue = subwayGraph[row]
    }
}

extension FormViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        subwayGraph.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        subwayGraph[row]
    }

}
