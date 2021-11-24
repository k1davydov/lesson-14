//
//  RealmCell.swift
//  Lesson 14
//
//  Created by Kirill Davydov on 23.11.2021.
//

import UIKit

class RealmCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    func initCell (_ task: String) {
        label.text = task
    }
}
