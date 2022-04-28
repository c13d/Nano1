//
//  NewExerciseViewController.swift
//  Nano1
//
//  Created by Christophorus Davin on 27/04/22.
//

import UIKit

class NewExerciseViewController: UIViewController {
    
    var selectedDay = [String]()
    
    let dayWeek = ["Sunday", "Monday", "Tuesday","Wednesday","Thursday","Friday","Saturday"]
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var dayTableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var endTime: UITextField!
    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        if let selectedRows = dayTableView.indexPathsForSelectedRows
        {
            for i in selectedRows
            {
                selectedDay.append(dayWeek[i.section])
            }
            
            print("\n")
            print("\n\nSelected Day: ")
            for i in selectedDay
            {
                print(i)
            }
        }
    
        guard let text = nameTextField.text, !text.isEmpty else{
            // showToast(message: "Name can't be empty")
            showAlert(message: "Name must be field")
            return
        }
        
        let f = DateFormatter()
        f.dateFormat = "HH:mm"
        
        if (f.date(from: startTime.text!)! >= f.date(from: endTime.text!)! )
        {
            showAlert(message: "Start time must be earlier end time")
            return
        }else if(selectedDay.count == 0){
            showAlert(message: "You must select at least one day of week")
            return
        }
        
        print(text)
        print("Start Time \(startTime.text!)")
        print("End Time \(endTime.text!)")
        
        
        
        
        self.createItem(name: text)

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Save has failed", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {action in
            print("tapped Ok")
        }))
        
        present(alert, animated: true)
    }
    
    func showActionSheet(){
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Exercise"
        
        nameTextField.delegate = self
        
        startTimeFunc()
        endTimeFunc()
    }
    
    
    func startTimeFunc(){
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar
        startTime.inputAccessoryView = toolbar
        
        // time
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        startTime.text = formatter.string(from: time)
        startTime.textColor = .link
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 250)
        timePicker.preferredDatePickerStyle = .wheels
        
        startTime.inputView = timePicker
    }
    
    func endTimeFunc(){
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressedEnd))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar
        endTime.inputAccessoryView = toolbar
        
        //time
        let time = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        endTime.text = formatter.string(from: time)
        endTime.textColor = .link
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValueChangedEnd(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 250)
        timePicker.preferredDatePickerStyle = .wheels
        
        endTime.inputView = timePicker
    }
    
    @objc func donePressed(){
        self.view.endEditing(true)
    }
    
    
    @objc func timePickerValueChanged(sender: UIDatePicker)
    {
        //when time is changed it will appear here
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        startTime.text = formatter.string(from: sender.date)
    }
    
    @objc func donePressedEnd(){
        self.view.endEditing(true)
    }
    
    @objc func timePickerValueChangedEnd(sender: UIDatePicker)
    {
        //when time is changed it will appear here
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_gb")
        formatter.dateFormat = "HH:mm"
        endTime.text = formatter.string(from: sender.date)
    }
    
    func createItem(name: String){
        let newItem = ExerciseList(context: context)
        newItem.name = name
        newItem.startTime = startTime.text
        newItem.endTime = endTime.text
        newItem.dayWeek = selectedDay
        newItem.createdAt = Date()
        
        do{
            try context.save()
        }catch{
            
        }
    }
    
    func showToast(message: String){
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.width/2-150, y: self.view.frame.height - 72, width: 300, height: 40))
        
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.6)
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        toastLabel.text = message
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, delay: 1.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }){(isCompleted) in
            toastLabel.removeFromSuperview()
        }
    }
}

extension NewExerciseViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
}

extension NewExerciseViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dayWeek.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dayTableView.dequeueReusableCell(withIdentifier: "dayWeekCell", for: indexPath)
        cell.textLabel?.text = dayWeek[indexPath.section]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dayTableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        dayTableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    
}

extension ViewController{
    
    
}
