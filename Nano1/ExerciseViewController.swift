//
//  ExerciseViewController.swift
//  Nano1
//
//  Created by Christophorus Davin on 27/04/22.
//

import UIKit

class ExerciseViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var sampleData = [ExerciseModel(name: "Exercise 1"),
                      ExerciseModel(name: "Exercise 2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Exercise"
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ExerciseViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as? ExerciseTableViewCell)!
        cell.object = sampleData[indexPath.row]
        return cell
    }
    
    
}
