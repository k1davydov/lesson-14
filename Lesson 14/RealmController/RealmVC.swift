//
//  RealmVC.swift
//  Lesson 14
//
//  Created by Kirill Davydov on 23.11.2021.
//

import UIKit

class RealmVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addTaskButtonAction(_ sender: Any) {
        let alertController = addTaskAlertController { taskName in
            RealmPersistance.shared.addTask(taskName)
            self.tableView.reloadData()
        }
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func deleteTasksActionButton(_ sender: Any) {
        let alertController = addDeleteAlertController {
            RealmPersistance.shared.deleteAllTasks()
            self.tableView.reloadData()
        }
        present(alertController, animated: true, completion: nil)
    }
}

extension RealmVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        RealmPersistance.shared.getTasks().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RealmCell") as! RealmCell
        let tasks = RealmPersistance.shared.getTasks()
        cell.initCell(tasks[indexPath.row])
        return cell
    }
}
