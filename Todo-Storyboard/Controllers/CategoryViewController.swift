//
//  CategoryViewController.swift
//  Todo-Storyboard
//
//  Created by Irakli Sokhaneishvili on 12.03.22.
//

import UIKit

class CategoryViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Todoey"
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
}
