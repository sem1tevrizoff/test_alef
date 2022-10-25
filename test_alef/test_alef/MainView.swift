//
//  PersonalDataView.swift
//  test_alef
//
//  Created by sem1 on 24.10.22.
//

import UIKit

class MainView: UIView {
    
    var addButtonTapped: (() -> Void)?
    var deleteButtonTapped: ((Int) -> Void)?
    var removeButtonTapped: (() -> Void)?
    
    var children: [State.PersonalInformation] = [] {
        didSet {
            self.childrenTableView.reloadData()
        }
    }
    
    lazy var nameInfoView = PersonalInfoView()
    lazy var ageInfoView = PersonalInfoView()
    
    private let personalDataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "Персональные данные"
        return label
    }()
    
    private let childrenLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "Дети (макс.5)"
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 30
        button.layer.borderColor = UIColor.blue.cgColor
        button.sizeToFit()
        button.setTitle("+ Добавить ребенка", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(addChildren), for: .touchUpInside)
        return button
    }()
    
    private lazy var childrenTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset.left = 30
        tableView.separatorInset.right = 30
        tableView.register(ChildrenTableViewCell.self, forCellReuseIdentifier: ChildrenTableViewCell.reuseID)
        return tableView
    }()
    
    lazy var removeAllButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 30
        button.layer.borderColor = UIColor.red.cgColor
        button.sizeToFit()
        button.isHidden = true
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(removeAllChildren), for: .touchUpInside)
        return button
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
        setupNameStackView()
        setupAgeStackView()
        backgroundColor = .white
    }
    
    private func setupLayouts() {
        [personalDataLabel, nameInfoView, ageInfoView, childrenLabel, addButton, childrenTableView, removeAllButton].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            personalDataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            personalDataLabel.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            personalDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            personalDataLabel.heightAnchor.constraint(equalToConstant: 50),
            
            nameInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameInfoView.topAnchor.constraint(equalTo: personalDataLabel.bottomAnchor, constant: 10),
            nameInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameInfoView.heightAnchor.constraint(equalToConstant: 70),
            
            ageInfoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            ageInfoView.topAnchor.constraint(equalTo: nameInfoView.bottomAnchor, constant: 10),
            ageInfoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            ageInfoView.heightAnchor.constraint(equalToConstant: 70),
            
            childrenLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            childrenLabel.topAnchor.constraint(equalTo: ageInfoView.bottomAnchor, constant: 10),
            childrenLabel.widthAnchor.constraint(equalToConstant: 150),
            childrenLabel.heightAnchor.constraint(equalToConstant: 50),
            
            addButton.leadingAnchor.constraint(equalTo: childrenLabel.trailingAnchor, constant: 10),
            addButton.topAnchor.constraint(equalTo: ageInfoView.bottomAnchor, constant: 10),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 60),
            
            childrenTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            childrenTableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 10),
            childrenTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            childrenTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            
            removeAllButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            removeAllButton.topAnchor.constraint(equalTo: childrenTableView.bottomAnchor, constant: 10),
            removeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -80),
            removeAllButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupNameStackView() {
        nameInfoView.infoTextField.tag = 0
        nameInfoView.infoTextField.delegate = self
        nameInfoView.infoLabel.text = "Имя"
    }
    
    private func setupAgeStackView() {
        ageInfoView.infoTextField.delegate = self
        ageInfoView.infoTextField.tag = 1
        ageInfoView.infoTextField.keyboardType = .numbersAndPunctuation
        ageInfoView.infoLabel.text = "Возраст"
    }
    
    @objc func addChildren() {
        addButtonTapped?()
    }
    
    @objc func removeAllChildren() {
        removeButtonTapped?()
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

extension MainView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tagBasedTextField(textField)
        return true
    }
}

extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return children.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChildrenTableViewCell.reuseID) as? ChildrenTableViewCell else { return UITableViewCell() }
        
        cell.deleteChildrenInCell = { [weak self] in
            self?.deleteButtonTapped?(indexPath.row)
        }
        
        return cell
    }
    
}
