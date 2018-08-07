//
//  ViewController.swift
//  Todoey
//
//  Created by Charles Martin Reed on 8/7/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    //MARK - Setting up UserDefaults
    //used for storing information locally, between app launches
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Find Dave"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Find Tasha"
        itemArray.append(newItem3)

        
//        using the NSUserDefaults stored database to fill out our array
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {

            itemArray = items
        }
        
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
       
        //add or remove checkmark accessory to cell
        //using ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    //fired when we click on a cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //figure out whether or not the item on the list is done
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
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
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
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

