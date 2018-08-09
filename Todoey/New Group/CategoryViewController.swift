//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Charles Martin Reed on 8/8/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //dummy data for testing
//        let newCategory = Category()
//        newCategory.name = "Test Category"
//        categoryArray.append(newCategory)
        
//        loadCategory()
        
    }

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            //what happens when user tries to add a new category
            
            let newCategory = Category()
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            textField.placeholder = "Add a new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //trigger segue from the Category View Controller to ToDoList View Controller
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    //we need to init the list on the other end of our segue request with ONLY the items tht are relevant to the list in question
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC?.selectedCategory = categoryArray[indexPath.row]
        }
    }
  
    
    //MARK: - Data Manipulation Methods
    func save(category: Category) {

        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategory() {
//
//        do {
//            categoryArray = try context.fetch(request)
//        } catch {
//            print("Error retreiving categories: \(error)")
//        }
//
//        tableView.reloadData()
        }
}
