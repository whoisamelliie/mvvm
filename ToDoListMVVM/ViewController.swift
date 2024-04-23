//
//  ViewController.swift
//  ToDoListMVVM
//
//  Created by Amelie Baimukanova on 23.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textfield: UITextField!
    var viewModel: TaskViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = TaskViewModel { [unowned self] (state) in
            switch state.editingStyle {
                
            case .addTask(let string):
                textfield.text = ""
                break
            case .deleteTask(let indexPath):
                break
            case .toggleTask(let indexPath):
                break
            case .loadTasks(let array):
                break
            case .none:
                break
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.loadTask()
    }
    
    
    
    
@IBAction func addtask(_ sender: Any) {
    
    viewModel?.addNewTask(name: textfield.text!)
       
        
    }
    
    
    
    
}
