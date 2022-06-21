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
    private var subwayGraph: WeightedGraph<String, Int> {
        SubwayGraph().graph
    }

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
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 0.70)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textAlignment = .center
        label.text = formData.result
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 0.70)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textAlignment = .center
        label.text = "\(resultFromDijkstra.minimumTime) minutos"
        label.numberOfLines = 0
        return label
    }()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: "FormTableViewCell")

        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()

    private var currentPickerValue: String?

    init(type: FormType) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var resultFromDijkstra = ResultDijkstra.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTitle()
        setupComponents()
    }

    private func setupComponents() {
        setupNavigation()
        setupHeaderImageIfNeeded()
        setupIndicatorLabelIfNeeded()
        setupPickerViewIfNeeded()
        setupResultLabelIfNeeded()
        setupTableViewIfNeeded()
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
            
            guard let from = formData.from else { return }
            guard let to = formData.to else { return }
            resultFromDijkstra = dijkstra(root: from,
                                          destination: to)
        case .result:
            navigationController?.popToRootViewController(animated: true)
            return
        }
        navigationController?.pushViewController(
            FormViewController(type: nextType),
            animated: true
        )
    }

}

extension FormViewController {

    private func setupNavigation() {
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor(red: 0.10, green: 0.33, blue: 0.10, alpha: 1.00)
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

    private func setupHeaderImageIfNeeded() {
        guard type != .result else { return }
        view.addSubview(headerImage)
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            headerImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            headerImage.heightAnchor.constraint(equalTo: headerImage.widthAnchor)
        ])
    }

    private func setupIndicatorLabelIfNeeded() {
        guard type != .result else { return }
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
    
    private func setupTableViewIfNeeded() {
        guard type == .result else { return }
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor,
                                           constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.reloadData()
    }

    private func setupResultLabelIfNeeded() {
        guard type == .result else { return }
        view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 32),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        view.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 4),
            timeLabel.heightAnchor.constraint(equalToConstant: 32),
            timeLabel.widthAnchor.constraint(equalToConstant: 150),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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

// MARK: Table View
extension FormViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultFromDijkstra.route.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FormTableViewCell", for: indexPath) as! FormTableViewCell

        let stop = resultFromDijkstra.route[indexPath.row]
        let indexStop = subwayGraph.indexOfVertex(stop)
        let (subwayLine, subwayLineColor) = verifySubwayLine(indexStop: indexStop!)

        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Embarque"
            cell.stopLabel.text = resultFromDijkstra.route[indexPath.row]
            cell.bgTitleView.isHidden = false
            cell.setupColorBg(typeOfStop: .boarding)
        case resultFromDijkstra.route.count - 1:
            cell.titleLabel.text = "Desembarque"
            cell.stopLabel.text = resultFromDijkstra.route[indexPath.row]
            cell.bgTitleView.isHidden = false
            cell.setupColorBg(typeOfStop: .landing)
        default:
            if let labelInfo = verifyStop(indexStop: indexStop!) {
                cell.titleLabel.text = labelInfo
                cell.bgTitleView.isHidden = false
                cell.setupColorBg(typeOfStop: .integration)
            } else {
                cell.bgTitleView.isHidden = true
            }

            cell.stopLabel.text = resultFromDijkstra.route[indexPath.row]
        }
        
        cell.subtitleLabel.text = subwayLine
        cell.subtitleLabel.textColor = subwayLineColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: Dijkstra Method
extension FormViewController {
    func dijkstra(root: String, destination: String) -> ResultDijkstra {
        let (weights, pathDict) = subwayGraph.dijkstra(root: root, startDistance: 0)
        let weightFromRootToVertice: [String: Int?] = distanceArrayToVertexDict(
            distances: weights,
            graph: subwayGraph
        )

        let minimumTimeResult = weightFromRootToVertice[destination] as? Int
        let pathResult: [WeightedEdge<Int>] = pathDictToPath(
            from: subwayGraph.indexOfVertex(root)!,
            to: subwayGraph.indexOfVertex(destination)!,
            pathDict: pathDict
        )
        let stops: [String] = subwayGraph.edgesToVertices(edges: pathResult)

        if let minimumTime = minimumTimeResult {
            resultFromDijkstra.minimumTime = minimumTime
        }
        resultFromDijkstra.route = stops

        return resultFromDijkstra
    }
}
