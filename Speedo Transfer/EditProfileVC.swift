//
//  EditProfileVC.swift
//  Speedo Transfer
//
//

import UIKit
import FittedSheets

class EditProfileVC: UIViewController, CountrySelectionDelegate {

    @IBOutlet weak var fullNameTxtField: CustomTextField!
    
    @IBOutlet weak var EmailTxtField: CustomTextField!
    
    @IBOutlet weak var Country: CustomTextField!
    
    @IBOutlet weak var DOBTxtField: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.style = .editor
        title = "Edit Profile"
        setUpUI()
    }
    private func isValidData() -> Bool {
        guard let name = fullNameTxtField.text?.trimmed, !name.isEmpty else {
            showALert(title: "Sorry", message: "Please enter your name!")
            return false
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.com"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        guard let email = EmailTxtField.text?.trimmed, !email.isEmpty, emailPredicate.evaluate(with: email) else {
            showALert(title: "Sorry", message: "Please enter a valid email address!")
            return false
        }
       
        
     
       
        
        
        return true
    }
    private func setUpUI(){
        fullNameTxtField.setType(.name)
        fullNameTxtField.placeholder = "Enter your full name"
        EmailTxtField.setType(.email)
        EmailTxtField.placeholder = "Enter your email"
        Country.setType(.country)
        Country.placeholder = "Select your country"
        
        Country.addTarget(self, action: #selector(showCountryPicker), for: .editingDidBegin)
        
        DOBTxtField.setType(.dateOfBirth)
        DOBTxtField.placeholder = "DD/MM/YYYY"
        
    }
    @objc func showCountryPicker() {
        guard let countrySheet = storyboard?.instantiateViewController(withIdentifier: "countrySheetVC") as? countrySheetVC else {
            print("Could not instantiate countrySheetVC")
            return
        }
        countrySheet.delegate = self
        
        let sheetController = SheetViewController(controller: countrySheet, sizes: [.fixed(500), .percent(0.5), .intrinsic])
        sheetController.cornerRadius=50
        sheetController.gripColor=UIColor(named: "LabelColor")
        self.present(sheetController, animated: true, completion: nil)
    }
    
    func didSelectCountry(country: Country) {
        Country.text = country.label
        
    }
    
    @IBAction func SaveButtonTapped(_ sender: Any) {
       
            if isValidData() {
               
                self.showALert(title: "Success", message: "Changed Successfully!")
    //            self.navigationController?.popViewController(animated: true)
            
        }
        
    }
}
