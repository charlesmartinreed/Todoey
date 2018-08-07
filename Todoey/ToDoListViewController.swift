//
//  ViewController.swift
//  Todoey
//
//  Created by Charles Martin Reed on 8/7/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Order groceries", "Plot out a good first iOS app", "Finish reading The Black Jacobins", "Rent A Wrinkle In Time"]
    
    //MARK - Setting up UserDefaults
    //used for storing information locally, between app launches
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //using the NSUserDefaults stored database to fill out our array
        if let itemArray = defaults.array(forKey: "TodoListArray") as? [String] {
            
            itemArray = items
        }
        
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    //fired when we click on a cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //add or remove checkmark accessory to cell
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //make the selection animation fade-out
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //used for our user's text
        var textField = UITextField()
        
        //create an alert
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //add new item to todo list, reload the tableView to show the new data
            self.itemArray.append(textField.text!)
            
            //save updated array to userdefaults
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
        }
        
        //adding the text field to our alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField //needed because alertTextField is only scoped to this closure
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

        
    }
    

}

