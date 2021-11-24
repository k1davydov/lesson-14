//
//  CoreDataVC.swift
//  Lesson 14
//
//  Created by Kirill Davydov on 23.11.2021.
//

import UIKit
import CoreData

class CoreDataVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addTaskButtonAction(_ sender: Any) {
        let alertController = addTaskAlertController { taskName in
            CoreDataPersistance.shared.addTask(taskName)
            self.tableView.reloadData()
        }
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func deleteTasksButtonAction(_ sender: Any) {
        let alertController = addDeleteAlertController {
            CoreDataPersistance.shared.deleteAllTasks()
            self.tableView.reloadData()
        }
        present(alertController, animated: true, completion: nil)
    }
}

extension CoreDataVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CoreDataPersistance.shared.getTasks().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoreDataCell") as! CoreDataCell
        let task = CoreDataPersistance.shared.getTasks()[indexPath.row]
        cell.iniCell(task.value(forKey: "name") as? String)
        return cell
    }
}
