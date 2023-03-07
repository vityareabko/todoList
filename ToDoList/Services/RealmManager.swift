//
//  RealmManager.swift
//  ToDoList
//
//  Created by Витя Рябко on 07/03/23.
//

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    private init() {}
    
    // Open the local-only default realm
    let realm = try! Realm()
    
    func saveTaskModel(model: TaskModel) {
        try! realm.write {
            realm.add(model)
        }
    }
    
}

