//
//  ViewController.swift
//  Project7ToDoList
//
//  Created by Ana Caroline de Souza on 03/01/20.
//  Copyright © 2020 Ana e Leo Corp. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var itemsList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "To-do List app!"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addListItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(eraseAllListContent))
        
    }

    @objc func eraseAllListContent(){
        itemsList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            itemsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    @objc func addListItem(){
        
        let ac = UIAlertController(title: "Enter the new list item:", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let listItem = ac?.textFields?[0].text else { return }
            self?.submit(listItem)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListItem", for: indexPath)
        cell.textLabel?.text = itemsList[indexPath.row]
        return cell
    }
    
    func submit(_ listItem: String){
        itemsList.insert(listItem, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        return
    }
    
}

