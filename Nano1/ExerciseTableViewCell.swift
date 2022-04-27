//
//  ExerciseTableViewCell.swift
//  Nano1
//
//  Created by Christophorus Davin on 27/04/22.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exerciseTitle: UILabel!
    
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

        // Configure the view for the selected state
    }
    
    func setupView() {
        guard let data = object else { return }
        exerciseTitle.text = data.name
        
    }

}
