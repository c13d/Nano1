//
//  HomeTableViewCell.swift
//  Nano1
//
//  Created by Christophorus Davin on 28/04/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    
    @IBOutlet weak var exerciseTimeLabel: UILabel!
    
    @IBAction func rescheduleButton(_ sender: Any) {
        
    }
    
//    func showAlert(message: String){
//        let alert = UIAlertController(title: "Reschedule", message: "", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {action in
//            print("tapped Ok")
//        }))
//
//        present(alert, animated: true)
//    }
    
    
    var object: ExerciseModel? {
        didSet {
            setupView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        guard let data = object else { return }
        exerciseNameLabel.text = data.name
        exerciseTimeLabel.text = "\(data.startTime!) - \(data.endTime!)"
    }

}

