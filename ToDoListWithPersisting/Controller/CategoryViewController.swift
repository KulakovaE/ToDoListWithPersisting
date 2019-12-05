//
//  CategoryViewController.swift
//  ToDoListWithPersisting
//
//  Created by Elena Kulakova on 2019-12-05.
//  Copyright © 2019 Elena Kulakova. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Category]()
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
//MARK: - TableView DataSource Methods
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return categories.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
       
    cell.textLabel?.text = categories[indexPath.row].name
       
       return cell
   }
    
//MARK: - Data Manipulation Methods
        func saveCategory() {
            
            do {
                try contex.save()
            } catch {
                print("Error saving contex \(error)")
            }
            
            self.tableView.reloadData()
        }
        
        func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()){

            do {
                categories = try contex.fetch(request)
            } catch {
                print("Error fetching data from context \(error)")
            }
            tableView.reloadData()
        }
    
//MARK: - TableViewDelegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
//MARK: - Add item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add New Category", style: .default) { (action) in
            //what will happen once the user clicks on UIAlert
            
            
            let newItem = Category(context: self.contex)
            
            newItem.name = textField.text!
            
            self.categories.insert(newItem, at: 0)
            
            self.saveCategory()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
