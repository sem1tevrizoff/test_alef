//
//  ChildrenTableViewCell.swift
//  test_alef
//
//  Created by sem1 on 24.10.22.
//

import UIKit

class ChildrenTableViewCell: UITableViewCell {
    
    static var reuseID: String {
        String(describing: self)
    }
    
    var deleteChildrenInCell: (() -> Void)?
    
    private let nameInfoView = PersonalInfoView()
    private let ageInfoView = PersonalInfoView()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(deleteChildren), for: .touchUpInside)
        return button
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        mainSetup()
    }
    
    private func mainSetup() {
        setupLayouts()
        setupLayoutConstraints()
        setupNameStackView()
        setupAgeStackView()
    }
    
    private func setupLayouts() {
        [nameInfoView, ageInfoView, deleteButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            nameInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameInfoView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -200),
            nameInfoView.heightAnchor.constraint(equalToConstant: 70),
            
            ageInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            ageInfoView.topAnchor.constraint(equalTo: nameInfoView.bottomAnchor, constant: 10),
            ageInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -200),
            ageInfoView.heightAnchor.constraint(equalToConstant: 70),
            
            deleteButton.leadingAnchor.constraint(equalTo: nameInfoView.trailingAnchor),
            deleteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            deleteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupNameStackView() {
        nameInfoView.infoLabel.text = "Имя"
        nameInfoView.infoTextField.delegate = self
        nameInfoView.infoTextField.tag = 0
    }
    
    private func setupAgeStackView() {
        ageInfoView.infoLabel.text = "Возраст"
        ageInfoView.infoTextField.keyboardType = .numbersAndPunctuation
        ageInfoView.infoTextField.delegate = self
        ageInfoView.infoTextField.tag = 1
    }
    
    @objc func deleteChildren() {
        deleteChildrenInCell?()
    }
    
    private func tagBasedTextField(_ textField: UITextField) {
        let nextTextFieldTag = textField.tag + 1

        if let nextTextField = textField.superview?.viewWithTag(nextTextFieldTag) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
}

extension ChildrenTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tagBasedTextField(textField)
        return true
    }
}

