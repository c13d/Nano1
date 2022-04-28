//
//  ExerciseViewController.swift
//  Nano1
//
//  Created by Christophorus Davin on 27/04/22.
//

import UIKit

class ExerciseViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    
    var sampleData = [ExerciseModel(name: "Exercise 1"),
                      ExerciseModel(name: "Exercise 2")]
    
    var models = [ExerciseList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)

        
        title = "My Exercise"
        getAllItems()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    @objc func refresh() {
        getAllItems() // a refresh the tableView.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllItems()
    }
    
    
    // Core Data
    func getAllItems(){
        do{
            models = try context.fetch(ExerciseList.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            
        }
    }
    
    func createItem(name: String){
        let newItem = ExerciseList(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do{
            try context.save()
        }catch{
            
        }
    }
    
    func deleteItem(item: ExerciseList){
        
        context.delete(item)
        do{
            try context.save()
        }catch{
            
        }
        
    }
    
    func updateItem(item: ExerciseList, newName: String){
        item.name = newName
        do{
            try context.save()
        }catch{
            
        }
        
    }
    
}

extension ExerciseViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.row]
        let cell = (tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as? ExerciseTableViewCell)!
        //cell.object = sampleData[indexPath.row]
        cell.exerciseTitle?.text = model.name
        return cell
    }
}
