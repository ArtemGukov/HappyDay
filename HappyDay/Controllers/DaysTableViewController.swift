//
//  DaysTableViewController.swift
//  HappyDay
//
//  Created by Артем on 10/07/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

class DaysTableViewController: UITableViewController {
    
    var birthdays = [Birthday]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
    }
    

    // MARK: - Table view data source
    
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdays.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let birthday = birthdays[indexPath.row]
        
        cell.textLabel?.text = birthday.firstName + " " + birthday.lastName
        cell.detailTextLabel?.text = dateFormatter.string(from: birthday.birthdayDate as! Date)
        
        return cell
    }
    

    // MARK: - IBActions
    
    @IBAction func unwindSaveTapped(_ segue: UIStoryboardSegue) {

    }
    
    @IBAction func unwindCancelTapped(_ segue: UIStoryboardSegue) {
        
    }
}

