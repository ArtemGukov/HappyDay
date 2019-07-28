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
    
    //    MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return monthsSection.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return events[monthsSection[section]]!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let newEvent = events[monthsSection[indexPath.section]]!
        
        cell.textLabel?.text = newEvent[indexPath.row].lastName! + " " + newEvent[indexPath.row].firstName!

//        dateFormatter.dateFormat = "dd MMMM yyyy"
//        let dateString = dateFormatter.string(from: (newEvent[indexPath.row]).eventDate!)
        
        cell.detailTextLabel?.text = newEvent[indexPath.row].age!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let calendar = Calendar.current
        let currentYear = String(calendar.component(.year, from: Date()))
    
        return (monthsSection[section] + " " + currentYear)
    }
    
    //    MARK: - Delete & edit cell
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
            
            self.events[self.monthsSection[indexPath.section]]?.remove(at: indexPath.row)
            
            if self.events[self.monthsSection[indexPath.section]]!.isEmpty {
                self.monthsSection.delete(element: self.monthsSection[indexPath.section])
            }
            
            tableView.reloadData()
        })
    
        deleteAction.backgroundColor = UIColor.red
    
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
            
            //tableView.reloadData()
        })
        editAction.backgroundColor = UIColor.orange
        
        return [deleteAction, editAction]
    }
    
    //    MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "detail" else { return }
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailEventViewController = segue.destination as! DetailEventlViewController
                detailEventViewController.birthday = events[monthsSection[indexPath.section]]![indexPath.row]
            }
        }
    
    // MARK: - IBActions
    
    @IBAction func unwindSaveTapped(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindCancelTapped(_ segue: UIStoryboardSegue) {
        
    }
}


