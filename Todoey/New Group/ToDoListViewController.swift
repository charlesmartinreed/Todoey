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

    var selectedCategory: Category? {
        didSet {
            //when set, during the segue, items will be loaded. This replaces our old view did load call.
            loadItems()
        }
    }
    
    var itemArray = [Item]()
    
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
    
    //MARK: - TableView Delegate Methods
    //fired when we click on a cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //MARK: UPDATING DATA FROM CORE DATA - 'U' IN CRUD
        //example of updating the database using KV coding
//        itemArray[indexPath.row].setValue("Completed", forKey: "title")
        
        //figure out whether or not the item on the list is done for checkmark
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //MARK: DELETING DATA FOR CORE DATA - 'D' IN CRUD
        //remove from the NSManagedObject in Core Data database
//        context.delete(itemArray[indexPath.row])
        
        //remove from itemArray - called after context.delete to avoid out of range causal loop error
//        itemArray.remove(at: indexPath.row)
        
        //SAVING TO OUR CORE DATA DATABASE
        saveItems()
        
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
            //context: self.context allows us to tie our data to Core Data
            let newItem = Item()
            newItem.title = textField.text!
            newItem.done = false
//            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
            self.saveItems()
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
    func saveItems() {
//
//        do {
//            try context.save()
//        } catch {
//            print("Error saving context \(error)")
//        }
//
//        self.tableView.reloadData()
    }
    
    //MARK: READING DATA FROM CORE DATA - 'R' IN CRUD
    //providing a default value for the param so that we can call at view load without giving it any parameters
    func loadItems() {
        
        //filtering results to allow for only selectedCategory and parentCategory matches to be shown
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//
//            request.predicate = categoryPredicate
//        }
        
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//
//        request.predicate = compoundPredicate
        
        //loading data via Core Data
        //since swift can't infer, we have to specify type for request AND the entity
       // let request: NSFetchRequest<Item> = Item.fetchRequest()
//        do {
//            //because we're storing items in an item array
//            //fetchRequest mandates a return, we're returning an array of Item entities
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error fetching data from context: \(error) ")
//        }
//
//        tableView.reloadData()
    }
    
}

//instead of adding a million different delegate methods at the class defintion, we can extend it as such
//MARK: - Search bar methods
//extension ToDoListViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        //reload the table view, using text that the user has entered
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//
//        //using NSPredicate - when we hit search, the query text is used to search whether the title of the entity attribute matches - case and diactric insensitive with [cd]
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        //sort the data returned
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        //return the filtered data to the tableView
//        loadItems(with: request, predicate: predicate)
//
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        //triggered when text is entered or, for our use case, when the x button is clicked to clear out the entered text
//
//        if searchBar.text?.count == 0 {
//            loadItems() //has a default request of pulling all items from our data store
//
//            //we need to speak to the main thread, by talking to the dispatch queue
//            //by doing this, we're able to update the UI
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder() //dismiss the keyboard, remove the cursor
//            }
//
//        }
//    }

//}
