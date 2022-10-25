//
//  PersonalInfoView.swift
//  test_alef
//
//  Created by sem1 on 24.10.22.
//

import UIKit

class PersonalInfoView: UIView {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 18)
        return label
    }()
    
    var infoTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func mainSetup() {
        setupLayouts()
        setupLayoutConstraints()
        layer.borderWidth = 1
    }
    
    private func setupLayouts() {
        [stackView, infoLabel, infoTextField].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(infoTextField)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 70),
        ])
        
        stackView.setCustomSpacing(-10, after: infoLabel)
    }

}
