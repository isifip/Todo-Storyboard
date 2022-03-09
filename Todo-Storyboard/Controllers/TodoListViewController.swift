//
//  ViewController.swift
//  Todo-Storyboard
//
//  Created by Irakli Sokhaneishvili on 09.03.22.
//

import UIKit

class TodoListViewController: UITableViewController  {
    
    let defaults = UserDefaults.standard
    
    var itemsArray = [Item]()
    
//    var itemsArray = ["Find Sugar", "Buy Eggs", "Dribble NBA2k", "Lorem ipsum", "dolor sit amet", "consectetur adipiscing", "sed do eiusmod", "tempor incididunt ut", "labore et dolore magna", "Ut enim ad minim", "quis nostrud exercitation", "ullamco laboris nisi", "aliquip ex ea commodo", "Lorem ipsum", "dolor sit amet", "consectetur adipiscing", "sed do eiusmod", "tempor incididunt ut", "ullamco laboris nisi", "aliquip ex ea commodo", "Lorem ipsum", "anim id est laborum", "aliquip ex ea commodo", "Lorem ipsum", "dolor sit amet", "consectetur adipiscing", "sed do eiusmod", "tempor incididunt ut", "ullamco laboris nisi", "aliquip ex ea commodo", "Lorem ipsum", "anim id est laborum"]

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
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemsArray = items
//        }
        
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
        
        tableView.deselectRow(at: indexPath, animated: false)
        tableView.reloadData()
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
            self.defaults.set(self.itemsArray, forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
}

