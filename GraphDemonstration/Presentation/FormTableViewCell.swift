//
//  FormTableViewCell.swift
//  GraphDemonstration
//
//  Created by Brena Amorim on 20/06/22.
//

import UIKit

class FormTableViewCell: UITableViewCell {
    
    let stackViewHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let stackViewVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 2
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stopLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bgTitleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
        
        setupLayout()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        bgTitleView.addSubview(titleLabel)
        stackViewHorizontal.addArrangedSubview(bgTitleView)
        stackViewHorizontal.addArrangedSubview(stopLabel)
        stackViewVertical.addArrangedSubview(stackViewHorizontal)
        stackViewVertical.addArrangedSubview(subtitleLabel)

        contentView.addSubview(stackViewVertical)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            bgTitleView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -4),
            bgTitleView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -8),
            bgTitleView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            bgTitleView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            stackViewVertical.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackViewVertical.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func setupColorBg(isBoarding: Bool) {
        if isBoarding {
            bgTitleView.backgroundColor = UIColor(red: 1.00, green: 0.98, blue: 0.65, alpha: 1.00)
            titleLabel.textColor = UIColor(red: 0.90, green: 0.51, blue: 0.00, alpha: 1.00)
        } else {
            bgTitleView.backgroundColor = UIColor(red: 0.71, green: 0.88, blue: 0.59, alpha: 1.00)
            titleLabel.textColor = UIColor(red: 0.10, green: 0.33, blue: 0.10, alpha: 1.00)
        }
    }
}
