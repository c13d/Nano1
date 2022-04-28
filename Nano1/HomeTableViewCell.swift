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
    
    @IBOutlet weak var Reschedule: UIButton!
    
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
