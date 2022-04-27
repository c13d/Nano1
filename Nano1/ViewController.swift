//
//  ViewController.swift
//  Nano1
//
//  Created by Christophorus Davin on 27/04/22.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate{
    
    @IBOutlet var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        calendar.delegate = self
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let selectedDate = formatter.string(from: date)
        print("\(selectedDate)")
    }
}

