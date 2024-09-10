//
//  secondSignupVC.swift
//  Speedo Transfer
//


import UIKit
import FittedSheets

class secondSignupVC: UIViewController, CountrySelectionDelegate {
    
    var tempUser: TempUser?
    
    @IBOutlet weak var signCountryTxtField: CustomTextField!
    @IBOutlet weak var signDateTxtField: CustomTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
       

    }
    
    private func setUpUI(){
        signCountryTxtField.setType(.country)
        signCountryTxtField.placeholder = "Select your country"
        
        signCountryTxtField.addTarget(self, action: #selector(showCountryPicker), for: .editingDidBegin)
        
        signDateTxtField.setType(.dateOfBirth)
        signDateTxtField.placeholder = "DD/MM/YYYY"
        
    }
    
    private func convertCountry(fullName: String) -> String? {
        let countryAbbreviations: [String: String] = [
            "United States": "US",
            "United Kingdom": "UK",
            "Egypt": "EG",
        ]
        
        return countryAbbreviations[fullName]
    }
    private func convertDate(dateString: String) -> String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "dd/MM/yyyy" // Input format: "08/09/2024"
        
        if let date = inputDateFormatter.date(from: dateString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "yyyy-MM-dd" 
            //"2024-09-08"
            
            return outputDateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    @IBAction func continueBtnTapped(_ sender: Any) {
        
        guard let tempUser = tempUser else {
            // Handle missing user data
            return
        }
        
        let fullname = tempUser.name
        let email = tempUser.email
        let password = tempUser.password

        let country = convertCountry(fullName: signCountryTxtField.text ?? "Egypt") ?? "EG"

        let birthDate = convertDate(dateString: signDateTxtField.text ?? "08/09/2024") ?? "2024-09-08"

        let myUser: UserRegistrationRequest = UserRegistrationRequest(
            name: fullname,
            email: email,
            password: password,
            confirmPassword: password,
            country: country,
            birthDate: birthDate
        )
        
        APIManager.PostRegistrationData(user: myUser)
        

       //
    }
    
    private func goToLoginScreen() {
        let SignIn = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInViewController
        self.navigationController?.pushViewController(SignIn, animated: true)
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
        signCountryTxtField.text = country.label
        
    }
}
