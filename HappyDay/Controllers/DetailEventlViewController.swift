//
//  DetailViewController.swift
//  HappyDay
//
//  Created by Артем on 22/07/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

class DetailEventlViewController: UIViewController {
    
    //    MARK: - IB Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    //    MARK: - Properties

    var birthday: Event!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        
        nameLabel.text = birthday.lastName! + " " + birthday.firstName!
        phoneLabel.text = birthday.mobilePhone
        //dateLabel.text = DateFormatter.localizedString(from: birthday.birthdayDate, dateStyle: .medium, timeStyle: .none) + ", а возраст: " + "\(calculateAge())"
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
