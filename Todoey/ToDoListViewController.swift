//
//  ViewController.swift
//  Todoey
//
//  Created by Charles Martin Reed on 8/7/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["Order groceries", "Plot out a good first iOS app", "Finish reading The Black Jacobins", "Rent A Wrinkle In Time"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    


}

