//
//  DaysTableViewController.swift
//  HappyDay
//
//  Created by Артем on 10/07/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {
    
    //    MARK: - IBOutlets
    
    @IBOutlet weak var sortingSegmentControl: UISegmentedControl!
    
    //    MARK: - Properties
    
    var events: Dictionary<String, Array<Event>> = [:] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var monthsSection = [String]()

    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortingSegmentControl.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !monthsSection.isEmpty {
            navigationItem.leftBarButtonItem = editButtonItem
        }
    }
    
    //    MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return monthsSection.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return events[monthsSection[section]]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let newEvent = events[monthsSection[indexPath.section]]!
        
        cell.textLabel?.text = newEvent[indexPath.row].lastName! + " " + newEvent[indexPath.row].firstName!
        
        cell.detailTextLabel?.text = newEvent[indexPath.row].age!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let calendar = Calendar.current
        let currentYear = String(calendar.component(.year, from: Date()))
    
        print(#line, #function, self.monthsSection)

        return (monthsSection[section] + " " + currentYear)
    }
    
    //    MARK: - Delete & edit cell
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
            
            self.events[self.monthsSection[indexPath.section]]?.remove(at: indexPath.row)
            
            if self.events[self.monthsSection[indexPath.section]]!.isEmpty {
                self.events.removeValue(forKey: self.monthsSection[indexPath.section])
                self.monthsSection.delete(element: self.monthsSection[indexPath.section])

                //print(#line, #function, self.monthsSection)
            }
            
            tableView.reloadData()
        })
    
        deleteAction.backgroundColor = UIColor.red
    
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")

            tableView.reloadData()
        })
        editAction.backgroundColor = UIColor.orange
        
        return [deleteAction, editAction]
    }
    
    //    MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "detailSegue":
        
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailEventViewController = segue.destination as! DetailEventViewController
                detailEventViewController.currentEvent = events[monthsSection[indexPath.section]]![indexPath.row]
            }
            
        case "editSegue":
            print("Error")
        default:
            print("Error")
        }
        }
    
    // MARK: - IBActions
    
    @IBAction func unwindSaveTapped(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindCancelTapped(_ segue: UIStoryboardSegue) {
        
    }
}


