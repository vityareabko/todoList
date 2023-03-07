//
//  TaskModel.swift
//  ToDoList
//
//  Created by Витя Рябко on 06/03/23.
//

import RealmSwift

class TaskModel : Object{
    @Persisted var task : String
}
