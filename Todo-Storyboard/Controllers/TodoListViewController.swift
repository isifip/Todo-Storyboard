//
//  ViewController.swift
//  Todo-Storyboard
//
//  Created by Irakli Sokhaneishvili on 09.03.22.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController  {
    
    var itemsArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
        
        title = "Todoey"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: --> TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemsArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.status ? .checkmark : .none

        return cell
    }
    
    //MARK: --> TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemsArray[indexPath.row].status.toggle()
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    //MARK: --> Add New Items
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.status = false
            self.itemsArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: --> Model Methods
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemsArray = try context.fetch(request)
            
        } catch {
            print("Error fetching data from context: \(error)")
        }
    }
}

