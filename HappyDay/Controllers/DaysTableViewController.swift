//
//  DaysTableViewController.swift
//  HappyDay
//
//  Created by Артем on 10/07/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

class DaysTableViewController: UITableViewController {
    
    //    MARK: IBOutlets
    
    @IBOutlet weak var sortingSegmentControl: UISegmentedControl!
    
    var birthdays = [Birthday]() {
        didSet {
            tableView.reloadData()
        }
    }

    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupViewDate()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return birthdays.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let birthdayNew = birthdays[indexPath.row]

        cell.textLabel?.text = birthdayNew.lastName + " " + birthdayNew.firstName
        cell.detailTextLabel?.text = dateFormatter.string(from: birthdayNew.birthdayDate)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return nil
    }
    
    // MARK: - Custom methods
    
    func setupViewDate() {
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        //dateFormatter.locale = Locale(identifier: "ru_RU")
    }
    
    func setupUI() {
        
        sortingSegmentControl.isHidden = true
    }
    
    // MARK: - IBActions
    
    @IBAction func unwindSaveTapped(_ segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindCancelTapped(_ segue: UIStoryboardSegue) {
        
    }
}
