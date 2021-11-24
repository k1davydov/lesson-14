//
//  CoreDataCell.swift
//  Lesson 14
//
//  Created by Kirill Davydov on 23.11.2021.
//

import UIKit

class CoreDataCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
 
    func iniCell(_ task: String?) {
        label.text = task
    }
}
