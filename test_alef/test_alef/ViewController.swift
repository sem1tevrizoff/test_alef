//
//  ViewController.swift
//  test_alef
//
//  Created by sem1 on 24.10.22.
//

import UIKit

class ViewController: UIViewController {
    
    var state: State = State() {
        didSet {
            updateState()
        }
    }
    
    private let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainSetup()
    }
    
    private func mainSetup() {
        addChildren()
    }
    
    private func setupLayouts() {
        [mainView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func updateState() {
        setChildren(state.children)
        setupVisibleAddButton()
        setupVisibleRemoveButton()
        deleteButtonTapped()
        removeAllButton()
    }
    
    private func setChildren(_ children: [State.PersonalInformation]) {
        mainView.children = children
    }
    
    private func addChildren() {
        mainView.addButtonTapped = { [weak self] in
            self?.state.addEmptyChild()
        }
    }
    
    private func setupVisibleAddButton() {
        mainView.addButton.isHidden = state.childrenCount == 0
        mainView.addButton.isHidden = !state.canAddChild
    }
    
    private func deleteButtonTapped() {
        mainView.deleteButtonTapped = { [weak self] section in
            self?.state.removeChild(at: section)
        }
    }
    
    private func setupVisibleRemoveButton() {
        mainView.removeAllButton.isHidden = state.childrenCount == 0
    }
    
    private func removeAllButton() {
        mainView.removeButtonTapped = { [weak self] in
            self?.showAllert()
        }
    }
    
    private func showAllert() {
        let alertVC = UIAlertController(title: "Сбросить данные?",
                                        message: nil,
                                        preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Сбросить данные", style: .destructive) { [weak self] _ in
            self?.configureAllertActions()
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default)
        
        alertVC.addAction(deleteAction)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true)
    }
    
    private func configureAllertActions() {
        state.removeAll()
        mainView.nameInfoView.infoTextField.text = ""
        mainView.ageInfoView.infoTextField.text = ""
    }
    
}

