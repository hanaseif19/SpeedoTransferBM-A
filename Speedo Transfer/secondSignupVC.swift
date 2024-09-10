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
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        
        guard let tempUser = tempUser else {
            // Handle missing user data
            return
        }
        
        let fullname = tempUser.name
        let email = tempUser.email
        let password = tempUser.password


        let user = UserRegistrationRequest(
            name: fullname,
            email: email,
            password: password

        )
        
        print("User object to be sent: \(user)")
        
        AuthService.registerUser(with: user) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("API Response: \(response)")
                    
                    self.goToLoginScreen()

                case .failure(let error):
                    print("API Error: \(error.localizedDescription)")
                    
                    self.goToLoginScreen()
                }
            }
        }
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
