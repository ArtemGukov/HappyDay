//
//  AddDayViewController.swift
//  HappyDay
//
//  Created by Артем on 10/07/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

class DayDetailViewController: UITableViewController {

    //    MARK: - IB Outlets
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldSurname: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var remindSwitch: UISwitch!
    
    @IBOutlet weak var scrollBottomConst: NSLayoutConstraint!
    

    
    //    MARK: - Properties

    let birthdayDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    
    var isBirthdayPickerShown = false {
        didSet {
            birthdayPicker.isHidden = !isBirthdayPickerShown
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupDateView()
        hideKeyboard()
    }

    //    MARK: Custom methods
    
    func setupDateView() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        //dateFormatter.locale = Locale(identifier: "ru_RU")
        birthdayPicker.maximumDate = Date()
        dateLabel.text = dateFormatter.string(from: birthdayPicker.date)
    }
    
    //    MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "saveSegue":
            
            let newBirthday = Birthday()
            
            newBirthday.id = UUID().uuidString
            newBirthday.firstName = textFieldName.text!
            newBirthday.lastName = textFieldSurname.text!
            newBirthday.mobilePhone = textFieldPhone.text!
            newBirthday.birthdayDate = birthdayPicker.date
            
            let destination = segue.destination as! DaysTableViewController
            destination.birthdays.append(newBirthday)
            
        case "cancelSegue":
            print("Cancel tapped")
            
        default:
            print("Error")
        }
    }
    
    //    MARK: IBActions
    
    @IBAction func datePickerValueChanged() {
        setupDateView()
    }
}

    // MARK: Extensions

extension DayDetailViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
        case birthdayDatePickerCellIndexPath:
            return isBirthdayPickerShown ? UITableView.automaticDimension : 0
        default:
            return UITableView.automaticDimension
        }
    }
}

extension DayDetailViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case birthdayDatePickerCellIndexPath.prevRow:
            isBirthdayPickerShown.toggle()
            isBirthdayPickerShown = isBirthdayPickerShown ? true : isBirthdayPickerShown
        default:
            return
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

// MARK: - Keyboard method
extension DayDetailViewController {
    func registerForKeyboardNotifications() {
        
        let names: [NSNotification.Name] = [
            UIResponder.keyboardWillShowNotification,
            UIResponder.keyboardWillHideNotification
        ]
        
        for name in names {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: name, object: nil)
        }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let constant: CGFloat
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            constant = kbFrameSize.height
        } else {
            constant = 0
        }
        
        scrollBottomConst.constant = constant + 20
        
    }
}
