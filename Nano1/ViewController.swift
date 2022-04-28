//
//  ViewController.swift
//  Nano1
//
//  Created by Christophorus Davin on 27/04/22.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDelegate{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var models = [ExerciseList]()
    var dataSources = [ExerciseModel]()
    var selectedDate:String = ""
    
    @IBOutlet var calendar: FSCalendar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let numbers = ["0","1","2","3","4","5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        calendar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // tableView.frame = view.bounds
        dayNow()
        getAllItems()
    }
    
    func dayNow(){
        // time
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        selectedDate = formatter.string(from: time)
        print("\(selectedDate)")
    }
    
    func changeDataSource(){
        dataSources.removeAll()
        for model in models {
            //let flag = false
            for day in model.dayWeek!{
                
                // print("selected: \(selectedDate)")
                if(day == selectedDate){
                    dataSources.append(ExerciseModel(name: model.name, startTime: model.startTime, endTime: model.endTime))
                    print("day: \(day)")
                    print(model.name!)
                }
            }
        }
        
        print("datasource count \(dataSources.count)")
    }
    
    // Core Data
    func getAllItems(){
        do{
            models = try context.fetch(ExerciseList.fetchRequest())
            changeDataSource()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        selectedDate = formatter.string(from: date)
        print("\(selectedDate)")
        
        getAllItems()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSources.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? HomeTableViewCell)!
        
        cell.object = dataSources[indexPath.section]
        return cell
    }
    
    
    

}
