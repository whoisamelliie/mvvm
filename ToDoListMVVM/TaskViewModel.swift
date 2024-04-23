//
//  TaskViewModel.swift
//  ToDoListMVVM
//
//  Created by Amelie Baimukanova on 23.04.2024.
//

import Foundation
import UIKit
struct State {
    enum EditingStyle {
        case addTask(String)
        case deleteTask(IndexPath)
        case toggleTask(IndexPath)
        case loadTasks([TaskItem])
        case none
    }
    
    var todolistarray: [TaskItem]
    var editingStyle: EditingStyle {
        didSet {
            switch editingStyle {
            case let .addTask(newTaskName):
                let newTask = TaskItem()
                newTask.name = newTaskName
                todolistarray.append(newTask)
                break
            case let .deleteTask(indexPath):
                todolistarray.remove(at: indexPath.row)
                break
            case let .toggleTask(indexPath):
                todolistarray[indexPath.row].isComplete.toggle()
                break
            case let .loadTasks(array):
                todolistarray = array 
                break
            case .none:
                break
            }
        }
    }
    init(array: [TaskItem]) {
        todolistarray = array
        editingStyle = .none
    }
    func text(at indexPath: IndexPath) -> String {
        return todolistarray[indexPath.row].name
    }
    func isTaskComplete(at indexPath: IndexPath) -> Bool {
        return todolistarray[indexPath.row].isComplete
    }
}
class TaskViewModel {
    var state = State(array: []) {
        didSet {
            callback(state)
        }
    }
    let callback: (State) -> ()
    init(callback: @escaping (State) -> ()) {
        self.callback = callback
    }
    func addNewTask(name: String) {
        state.editingStyle = .addTask(name)
        saveTask()
    }
    func deleteTask(at indexPath: IndexPath) {
        state.editingStyle = .deleteTask(indexPath)
        saveTask()
    }
    func toggleTask(at indexPath: IndexPath) {
        state.editingStyle = .toggleTask(indexPath)
        saveTask()
    }
    func accessoryType(at indexPath: IndexPath)  -> UITableViewCell.AccessoryType {
        if state.isTaskComplete(at: indexPath) {
            return.checkmark
            
        }
        return.none
    }
    
    func saveTask() {
        let defaults = UserDefaults.standard
        
        do {
            let encodedata = try JSONEncoder().encode(state.todolistarray)
            defaults.set(encodedata, forKey: "taskItemArray")
            
        } catch {
            print("unable to encode \(error)")
        }
        
    }
    func loadTask() {
        
        let defaults = UserDefaults.standard
        
        do {
            if let data = defaults.data(forKey: "taskItemArray"){
                
                let  array = try JSONDecoder().decode([TaskItem].self, from: data)
                state.editingStyle = .loadTasks(array)
            }
        } catch {
            print("unable to encode \(error)")
        }
    }
}

