//
//  TableViewController.swift
//  ToDoListMVVM
//
//  Created by Amelie Baimukanova on 23.04.2024.
//

import UIKit

class TableViewController: UITableViewController {

    var viewModel: TaskViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        viewModel = TaskViewModel { [unowned self] (state) in
            switch state.editingStyle {
            case .addTask(_):
                self.tableView.reloadData()
                break
            case .deleteTask(_):
                break
            case .toggleTask(_):
                self.tableView.reloadData()
                break
            case .loadTasks(_):
                self.tableView.reloadData()
                break
            case .none:
                self.tableView.reloadData()
                break
            
            }
            
        }
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel?.loadTask()
    }
    

        
        //defaults.set(arraytask, forKey: "taskArray")
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (viewModel?.state.todolistarray.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = viewModel?.state.text(at: indexPath)
        
       // cell.detailTextLabel?.text = arraytask[indexPath.row]
        // Configure the cell...
        cell.accessoryType = (viewModel?.accessoryType(at: indexPath))!
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.toggleTask(at: indexPath)
    }


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
     */
    
    // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             
             viewModel?.deleteTask(at: indexPath)
             tableView.deleteRows(at: [indexPath], with: .fade)
             
             
         } else if editingStyle == .insert {
             // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
     }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
