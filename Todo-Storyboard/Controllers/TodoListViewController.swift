//
//  ViewController.swift
//  Todo-Storyboard
//
//  Created by Irakli Sokhaneishvili on 09.03.22.
//

import UIKit

class TodoListViewController: UITableViewController  {
    
    var itemsArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()

        var newItem = Item()
        newItem.title = "Find Sugar"
        var newItem2 = Item()
        newItem2.title = "Buy Eggs"
        var newItem3 = Item()
        newItem3.title = "Lorem ipsum"
        itemsArray.append(newItem)
        itemsArray.append(newItem2)
        itemsArray.append(newItem3)
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemsArray = items
//        }
        self.tableView.reloadData()
        
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
            var newItem = Item()
            newItem.title = textField.text!
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
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemsArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item arra, \(error)")
        }
        
        self.tableView.reloadData()
    }
}

