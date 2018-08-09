//
//  ViewController.swift
//  Todoey
//
//  Created by Charles Martin Reed on 8/7/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

    var todoItems: Results<Item>?
    
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
            //when set, during the segue, items will be loaded. This replaces our old view did load call.
            loadItems()
        }
    }
    
    
    
    //MARK: - Setting up UserDefaults
    //used for storing information locally, between app launches
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //where our data is currently being stored
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        

        
//        using the NSUserDefaults stored database to fill out our array
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//
//            itemArray = items
//        }
        
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
            
        } else {
            cell.textLabel?.text = "No Items Added"

        }
        
        return cell
        
    }
    
    //MARK: - TableView Delegate Methods
    //fired when we click on a cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //toggle the checkmark on the checklist items
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    //click to remove item from the list -- NOT CURRENTLY USED
                    //realm.delete(item)
                    item.done = !item.done
                }
            } catch {
                print("Error saving done status: \(error)")
            }
            
        }
        
        tableView.reloadData()
        
        //make the selection animation fade-out
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: CREATING DATA FOR CORE DATA - 'C' IN CRUD
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //used for our user's text
        var textField = UITextField()
        
        //create an alert
        let alert = UIAlertController(title: "Add New Todoey", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //add new item to todo list, reload the tableView to show the new data
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        
                        currentCategory.items.append(newItem) //creates the relationship between item and category
                    }
                } catch {
                    print("Error saving data: \(error)")
                    }
                }
            
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
    
    //MARK - Save function
    
    //MARK: READING DATA FROM CORE DATA - 'R' IN CRUD
    //providing a default value for the param so that we can call at view load without giving it any parameters
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
    
}

//instead of adding a million different delegate methods at the class defintion, we can extend it as such
//MARK: - Search bar methods
extension ToDoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //querying with Realm - filtering the todoItems List
        //filtering by the query, case and diactric insensitive, and filtering by title from A-Z
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //triggered when text is entered or, for our use case, when the x button is clicked to clear out the entered text

        if searchBar.text?.count == 0 {
            loadItems() //has a default request of pulling all items from our data store

            //we need to speak to the main thread, by talking to the dispatch queue
            //by doing this, we're able to update the UI
            DispatchQueue.main.async {
                searchBar.resignFirstResponder() //dismiss the keyboard, remove the cursor
            }

        }
    }

}
