//
//  UserDefaultsVC.swift
//  Lesson 14
//
//  Created by Kirill Davydov on 23.11.2021.
//

import UIKit

class UserDefaultsVC: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let name = Persistance.shared.userName, let surname = Persistance.shared.userSurname else {
            print("UserDefaults is empty")
            return
        }
        nameTextField.text = name
        surnameTextField.text = surname
    }
    
    func checkNames() -> Bool {
        guard let name = nameTextField.text, name != "",
              let surname = surnameTextField.text, surname != "" else {
            let alert = UIAlertController(title: "Alert", message: "Please, enter name and surname", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        Persistance.shared.userName = name
        Persistance.shared.userSurname = surname
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if checkNames() {
            self.view.endEditing(true)
        }
    }
}



class Persistance {
    static let shared = Persistance()
    
    private let kUserNameKey = "Persistance.kUserNameKey"
    private let kUserSurnameKey = "Persistance.kUserSurnameKey"
    
    var userName: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: kUserNameKey)
        }
        get {
            return UserDefaults.standard.string(forKey: kUserNameKey)
        }
    }
    
    var userSurname: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: kUserSurnameKey)
        }
        get {
            return UserDefaults.standard.string(forKey: kUserSurnameKey)
        }
    }
}
