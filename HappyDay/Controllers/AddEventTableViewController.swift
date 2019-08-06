//
//  AddDayViewController.swift
//  HappyDay
//
//  Created by Артем on 10/07/2019.
//  Copyright © 2019 Gukov.tech. All rights reserved.
//

import UIKit

class AddEventTableViewController: UITableViewController {

    //    MARK: - IB Outlets
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldSurname: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var remindSwitch: UISwitch!
    
    @IBOutlet weak var scrollBottomConst: NSLayoutConstraint!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //    MARK: - Properties
    
    var currentEvent: Event?
    var newEvent = Event()

    let eventDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    
    var isEventPickerShown = false {
        didSet {
            birthdayPicker.isHidden = !isEventPickerShown
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEditScreen()
        saveButton.isEnabled = false
        setupDateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //setupDateView()
        hideKeyboard()
    }

    //    MARK: - Custom methods
    
    func setupDateView() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        //dateFormatter.locale = Locale(identifier: "ru_RU")
        birthdayPicker.maximumDate = Date()
        dateLabel.text = dateFormatter.string(from: birthdayPicker.date)
    }
    
    func updateUI() {
        saveButton.isEnabled = areFieldsReady()
    }
    
    func areFieldsReady() -> Bool {
        return !textFieldName.isEmpty && !textFieldSurname.isEmpty && !textFieldPhone.isEmpty
    }
    
    //    MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "saveSegue":
            
            let eventsTableViewController = segue.destination as! EventsTableViewController
            
            guard textFieldName.text != "", textFieldSurname.text != "" else { return }
            
            newEvent.id = UUID().uuidString
            newEvent.firstName = textFieldName.text!
            newEvent.lastName = textFieldSurname.text!
            newEvent.mobilePhone = textFieldPhone.text!
            newEvent.eventDate = birthdayPicker.date
            newEvent.age = calculateAge()
            
            if let dueDate = newEvent.eventDate {
                if eventsTableViewController.events[dueDate.month] == nil {
                    eventsTableViewController.events[dueDate.month] = [newEvent]
                    
                    print(#line, #function, newEvent)
                } else {
                    eventsTableViewController.events[dueDate.month]?.append(newEvent)
                }
                
                eventsTableViewController.monthsSection.removeAll(keepingCapacity: false)
                
                let formatter: DateFormatter = {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMMM"
                    return dateFormatter
                } ()
                
                eventsTableViewController.monthsSection = eventsTableViewController.events.keys.sorted(by: { formatter.date(from: $0)! < formatter.date(from: $1)! })
                
                eventsTableViewController.tableView.reloadData()
            }
            
            if currentEvent != nil {
                currentEvent?.id = newEvent.id
                currentEvent?.firstName = newEvent.firstName
                currentEvent?.lastName = newEvent.lastName
                currentEvent?.mobilePhone = newEvent.mobilePhone
                currentEvent?.eventDate = newEvent.eventDate
            }
            
        case "cancelSegue":
            print("Cancel tapped")
            
        default:
            print("Error")
        }
    }
    
    //    MARK: - Custom methods
    
    func calculateAge() -> String {
        let now = Date()
        let eventNew: Date = newEvent.eventDate!
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: eventNew, to: now)
        let age = String(ageComponents.year!)
        
        return age
    }
    
    private func setupEditScreen() {
        if currentEvent != nil {
            setupNavigationBar()
            
            textFieldName.text = currentEvent?.firstName
            textFieldSurname.text = currentEvent?.lastName
            textFieldPhone.text = currentEvent?.mobilePhone
            birthdayPicker.date = currentEvent!.eventDate!
            
        }
    }
    
    private func setupNavigationBar() {
        //navigationItem.leftBarButtonItem = nil
        title = currentEvent!.lastName! + " " + currentEvent!.firstName!
    }
    
    //    MARK: - IBActions
    
    @IBAction func datePickerValueChanged() {
        setupDateView()
    }
    
    @IBAction func textChange() {
        updateUI()
    }
}

    // MARK: - Extensions

extension AddEventTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
        case eventDatePickerCellIndexPath:
            return isEventPickerShown ? UITableView.automaticDimension : 0
        default:
            return UITableView.automaticDimension
        }
    }
}

extension AddEventTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case eventDatePickerCellIndexPath.prevRow:
            isEventPickerShown.toggle()
            isEventPickerShown = isEventPickerShown ? true : isEventPickerShown
        default:
            return
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

// MARK: - Keyboard method

extension AddEventTableViewController {
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

extension AddEventTableViewController {
    
    func alertWrongMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}
