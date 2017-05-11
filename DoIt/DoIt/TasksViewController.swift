//
//  TasksViewController.swift
//  DoIt
//
//  Created by JuanJ on 5/9/17.
//  Copyright © 2017 JJB. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var tasks: [Task] = []
    var selectedIndex  = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //poner información antes de asignar datasource y delegate
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTask()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.name
        if task.important {
            cell.textLabel?.text = "❗️\(task.name!)"
        }else {
            cell.textLabel?.text = task.name
        }
        return cell
    }
    
    //Segue en la celda 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row 
        let task = tasks[indexPath.row]
        performSegue(withIdentifier: "selectTaskSegue", sender: task)
    }
    

    
    @IBAction func plusTapped(_ sender: Any) {
        performSegue(withIdentifier: "addSegue", sender: nil)
    }
    
    // función saca los datos de core data y los mete en el array
    
    func getTask(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    // fetch tiene un throw lo que implica hacer un do try catch para el posible error
        
        do {
            tasks = try context.fetch(Task.fetchRequest()) as!  [Task]
            print(tasks)
        }catch {
            print("ERROR")
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
        if segue.identifier == "selectTaskSegue" {
            let nextVC = segue.destination as! CompleteTaskViewController
            nextVC.task = sender as! Task
            nextVC.previousVC = self
        }
    }
    
}

