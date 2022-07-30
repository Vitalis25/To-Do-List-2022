//
//  ToDoTableViewController.swift
//  To Do List 2022
//
//  Created by Vitally Ochnev on 28.07.2022.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    var todos = [ToDo]()
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        todos = [
            ToDo(title: "Купить молоко", image: UIImage(named: "milk")),
            ToDo(title: "Сходить на танцы", image: UIImage(named: "dance")),
            ToDo(title: "Сдать отчёт", image: UIImage(named: "report")),
        ]
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        let todo = todos[indexPath.row]
        configure(cell, with: todo)
        return cell
    }
    
    // MARK: - Cell Constant
    func configure(_ cell: ToDoCell, with todo: ToDo) {
        guard let stackView = cell.stackView else { return }
        guard stackView.arrangedSubviews.count == 0 else { return }
        
        for index in 0 ..< todo.keys.count {
            let key = todo.capitalizedKeys[index]
            let value = todo.values[index]
            
            if let stringValue = value as? String {
                
                let label = UILabel()
                label.text = "\(key): \(stringValue)"
                stackView.addArrangedSubview(label)
                
            } else if let dateValue = value as? Date {
                
                let label = UILabel()
                label.text = "\(key): \(dateValue.formattedDate)"
                stackView.addArrangedSubview(label)
                
            } else if let boolValue = value as? Bool {
                
                let label = UILabel()
                label.text = "\(key): \(boolValue ? "✅" : "⚪️")"
                stackView.addArrangedSubview(label)
                
            } else if let imageValue = value as? UIImage {
                
                let imageView = UIImageView(image: imageValue)
                let heightConstraint = NSLayoutConstraint(
                    item: imageView,
                    attribute: .height,
                    relatedBy: .equal,
                    toItem: nil,
                    attribute: .height,
                    multiplier: 1,
                    constant: 200
                )
                imageView.addConstraint(heightConstraint)
                imageView.contentMode = .scaleAspectFit
                stackView.addArrangedSubview(imageView)
                
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ToDoItemSegue" else { return }
        guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
        let destination = segue.destination as! ToDoItemTableViewController
        destination.todo = todos[selectedIndex.row].copy() as! ToDo
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveSegue" else { return }
        guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
        let source = segue.source as! ToDoItemTableViewController
        todos[selectedIndex.row] = source.todo
        if let toDoCell = tableView.cellForRow(at: selectedIndex) as? ToDoCell {
            if let stackView = toDoCell.stackView {
                stackView.arrangedSubviews.forEach { subview in
                    stackView.removeArrangedSubview(subview)
                    subview.removeFromSuperview()
                }
            }
        }
        tableView.reloadRows(at: [selectedIndex], with: .automatic)
    }
}
