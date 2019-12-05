//
//  ViewController.swift
//  ToDoListWithPersisting
//
//  Created by Elena Kulakova on 2019-12-02.
//  Copyright © 2019 Elena Kulakova. All rights reserved.
//

import UIKit
import CoreData

class ToDoViewController: UITableViewController {
    
    var itemArray = [Item]()
    //goes to the AppDelegate and grabs the persistentContainer, UIApplication.shared.delegate as! AppDelegate making object from the class AppDelegate
    let contex = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadItems()
    }
    
    //MARK: UITableViewDataSours Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: Add item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new ToDo item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks on UIAlert
            
            
            let newItem = Item(context: self.contex)
            
            newItem.title = textField.text!
            newItem.done = false
            
            self.itemArray.insert(newItem, at: 0)
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //MARK: Methods
    func saveItems() {
       
        do {
            try contex.save()
        } catch {
            print("Error saving contex \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try contex.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
}
