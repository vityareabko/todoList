//
//  TodoTableView.swift
//  ToDoList
//
//  Created by Витя Рябко on 06/03/23.
//

import UIKit
import RealmSwift

class TodoTableView: UITableView {
    
    private let identifierCell = "cell"
    public var tasks: Results<TaskModel>!
    
    override init(frame: CGRect, style: UITableView.Style) {
        
        super.init(frame: frame, style: .grouped)
        self.register(UITableViewCell.self, forCellReuseIdentifier: identifierCell)
        config()
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config(){
        self.backgroundColor = .white
        self.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension TodoTableView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let taskItem = tasks[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { action, view, handler in
            try! RealmManager.shared.realm.write {
                RealmManager.shared.realm.delete(taskItem)
                self.reloadData()
            }
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

extension TodoTableView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell, for: indexPath)
        let task = tasks[indexPath.row].task
        cell.textLabel?.text = task
        return cell
    }
}
