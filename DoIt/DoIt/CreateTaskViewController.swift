//
//  CreateTaskViewController.swift
//  DoIt
//
//  Created by JuanJ on 5/9/17.
//  Copyright © 2017 JJB. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {

    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var importantSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func addTapped(_ sender: Any) {
        //Create a Task from outlet information
        
        //getting access to core data through appDelegate
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let task = Task(context: context)
        task.name = taskNameTextField.text!
        task.important = importantSwitch.isOn
        
        //Para grabar en core data , pop back
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
     
        navigationController!.popViewController(animated: true)
    }
   



}
