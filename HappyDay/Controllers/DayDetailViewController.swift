//
//  AddDayViewController.swift
//  HappyDay
//
//  Created by Артем on 10/07/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

class DayDetailViewController: UITableViewController {
    
    //var birthDay = Birthday(id: "", firstName: "", lastName: "", mobilePhone: "", email: "", birthdayDate: Date())

    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldSurname: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var birthdayPicker: UIDatePicker!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        birthdayPicker.maximumDate = Date()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "saveSegue":
            
            let newBirthday = Birthday()
            
            newBirthday.id = UUID().uuidString
            
//            guard textFieldName.text != "" && textFieldPhone.text != "" else {
//                print("Заполните обязательные поля")
//                return }
            
            newBirthday.firstName = textFieldName.text!
            newBirthday.lastName = textFieldSurname.text!
            newBirthday.mobilePhone = textFieldPhone.text!
            newBirthday.email = textFieldEmail.text!
            newBirthday.birthdayDate = birthdayPicker.date
            
            let destination = segue.destination as! DaysTableViewController
            destination.birthdays.append(newBirthday)
            
            //print(#line, #function, newBirthday)
            
        case "cancelSegue":
            print("Cancel tapped")
            
        default:
            print("Error")
        }
    }
}
