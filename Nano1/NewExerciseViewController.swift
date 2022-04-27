//
//  NewExerciseViewController.swift
//  Nano1
//
//  Created by Christophorus Davin on 27/04/22.
//

import UIKit

class NewExerciseViewController: UIViewController {

    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "New Exercise"
    }
    

    

}
