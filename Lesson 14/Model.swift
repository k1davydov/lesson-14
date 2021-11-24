//
//  Model.swift
//  Lesson 14
//
//  Created by Kirill Davydov on 23.11.2021.
//

import Foundation
import UIKit

func addTaskAlertController(completion: @escaping (String) -> Void) -> UIAlertController {
    let alertController = UIAlertController(title: "Add", message: "Please, add new task", preferredStyle: .alert)
    let addAction = UIAlertAction(title: "Add", style: .default) { _ in
        guard let text = alertController.textFields?.first?.text else {
            print("Problem with textField in alertController")
            return
        }
        completion(text)
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alertController.addTextField(configurationHandler: nil)
    alertController.addAction(addAction)
    alertController.addAction(cancelAction)
    return alertController
}

func addDeleteAlertController(completion: @escaping () -> Void) -> UIAlertController{
    let alertController = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: .alert)
    let deleteACtion = UIAlertAction(title: "Delete", style: .default) { _ in
        completion()
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alertController.addAction(deleteACtion)
    alertController.addAction(cancelAction)
    return alertController
}
