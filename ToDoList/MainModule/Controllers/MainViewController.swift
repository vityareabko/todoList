//
//  ViewController.swift
//  ToDoList
//
//  Created by Витя Рябко on 06/03/23.
//

import UIKit

class MainViewController: UIViewController {
    
    private let tableView = TodoTableView()
    
    
    private lazy var addTask: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.backgroundColor = .none
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 28, weight: .bold)
        button.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        return button
    }()
    
    private let faketopView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2652178109, green: 0.4557970762, blue: 1, alpha: 1)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.countTodoTask = todoList
        
        setupUI()
    }

    private func setupUI() {
        self.view.backgroundColor = .white
        title = "ToDo List"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 24, weight: .bold)]
        
        let menuCustomBarButton = UIBarButtonItem(customView: addTask)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.2652178109, green: 0.4557970762, blue: 1, alpha: 1)
        navigationItem.rightBarButtonItem = menuCustomBarButton
        
        self.view.addSubview(faketopView)
        self.view.addSubview(tableView)
        self.view.addSubview(navigationController!.navigationBar)
        faketopView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        setConstraints()
    }
    
    @objc private func didTapAdd(_ sender: AnyObject) {
        print("tapped add")
        alertTextField()
    }
    
    private func alertTextField(){
        let alert = UIAlertController(title: "Your Task", message: "Input new task", preferredStyle: .alert)
        
        var alertTextField: UITextField!
        alert.addTextField(){ textField in
            alertTextField = textField
            textField.placeholder = "input task. "
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] action in
            guard let newTask = alertTextField.text, !newTask.isEmpty else { return }
            self?.tableView.todoList.append(newTask)
            self?.tableView.insertRows(at: [IndexPath.init(row: self!.tableView.todoList.count - 1, section: 0)], with: .automatic)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
     
        present(alert, animated: true)
    }
}

extension MainViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            faketopView.topAnchor.constraint(equalTo: self.view.topAnchor),
            faketopView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            faketopView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            faketopView.bottomAnchor.constraint(equalTo: navigationController!.navigationBar.topAnchor, constant: 10),
            
            tableView.topAnchor.constraint(equalTo: navigationController!.navigationBar.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

