//
//  NewExerciseViewController.swift
//  Nano1
//
//  Created by Christophorus Davin on 27/04/22.
//

import UIKit

class NewExerciseViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBAction func didTapCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        guard let text = nameTextField.text, !text.isEmpty else{
            return
        }
        
        print(text)
        self.createItem(name: text)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)

        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Exercise"
        
        nameTextField.delegate = self
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
}

extension NewExerciseViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    
}
