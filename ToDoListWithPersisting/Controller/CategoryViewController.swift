//
//  CategoryViewController.swift
//  ToDoListWithPersisting
//
//  Created by Elena Kulakova on 2019-12-05.
//  Copyright © 2019 Elena Kulakova. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    var categories: Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

//MARK: - TableView DataSource Methods
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return categories?.count ?? 1
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
       
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category added"
       
       return cell
   }
    
//MARK: - TableViewDelegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "CategoryToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ToDoViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
//MARK: - Data Manipulation Methods
    func save(category: Category) {
            
            do {
                try realm.write {
                    realm.add(category)
                }
            } catch {
                print("Error saving contex \(error)")
            }
            self.tableView.reloadData()
        }
        
        func loadCategories(){
            
            categories = realm.objects(Category.self)
            
            tableView.reloadData()
        }
    

//MARK: - Add item with TextField
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add New Category", style: .default) { (action) in
            //what will happen once the user clicks on UIAlert
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
