//
//  DetailViewController.swift
//  HappyDay
//
//  Created by Артем on 22/07/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

class DetailEventViewController: UIViewController {
    
    //    MARK: - IB Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    //    MARK: - Properties

    var currentEvent: Event!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        
        nameLabel.text = currentEvent.lastName! + " " + currentEvent.firstName!
        phoneLabel.text = currentEvent.mobilePhone
        //dateLabel.text = DateFormatter.localizedString(from: birthday.birthdayDate, dateStyle: .medium, timeStyle: .none) + ", а возраст: " + "\(calculateAge())"
    }
    
    //    MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "editSegue" else { return }
        guard let addEventTableViewController = segue.destination as? AddEventTableViewController else { return }
        addEventTableViewController.currentEvent = currentEvent
    }
    
    
    //    MARK: - IB Actions

    @IBAction func phonePressed(_ sender: UIButton) {
        
    }
    
    @IBAction func messagePressed(_ sender: UIButton) {
        
    }
    
    @IBAction func mailPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func wwwPressed(_ sender: UIButton) {
        
    }
}
