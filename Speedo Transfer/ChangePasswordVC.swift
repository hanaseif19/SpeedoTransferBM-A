//
//  ChangePasswordVC.swift
//  Speedo Transfer
//
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var newPasswordTextField: CustomTextField!
    @IBOutlet weak var currPasswordTextField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.style = .editor
        title = "Change Password"
        configureTextFields()
    }
    private func configureTextFields() {
        newPasswordTextField.setType(.password)
        newPasswordTextField.placeholder = "Enter your new password"
        currPasswordTextField.setType(.password)
        currPasswordTextField.placeholder = "Enter your old password"
    }
    private func isValidData() -> Bool {
    
        
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        guard let password = newPasswordTextField.text?.trimmed, !password.isEmpty, passwordPredicate.evaluate(with: password) else {
            showALert(title: "Sorry", message: "Password must be at least 8 characters long, with at least one uppercase letter, one lowercase letter, and one number.")
            return false
        }
        return true
        }
    
    @IBAction func saveButtonTap(_ sender: Any) {
        if isValidData() {
           
            self.showALert(title: "Success", message: "Password changed successfully!")
//      i want to remove here the vc       self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
