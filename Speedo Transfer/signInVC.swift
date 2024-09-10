//  SignInViewController.swift
//  Speedo Transfer
//

import UIKit
import LocalAuthentication

class SignInViewController: UIViewController {
    
    var context = LAContext()
    
    @IBOutlet weak var signInEmailTxtField: CustomTextField!
    @IBOutlet weak var signInPasswordTxtField: CustomTextField!
    
    //    private var presenter = SignInPresenter(apiClient: URLSessionApiClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
        self.navigationItem.hidesBackButton = true
        title = "Sign In"
        UserDefaults.standard.setValue(false, forKey: "isLoggedIn")
        
    }
    
    private func configureTextFields() {
        signInEmailTxtField.setType(.email)
        signInEmailTxtField.placeholder = "Enter your Email"
        signInPasswordTxtField.setType(.password)
        signInPasswordTxtField.placeholder = "Enter your Password"
    }
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignupVC
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func signInBtnTapped(_ sender: Any) {
        
        let login: LoginRequest = LoginRequest(email: signInEmailTxtField.text ?? "N/A", password: signInPasswordTxtField.text ?? "N/A")
        
        APIManager.PostLoginData(loginRequest: login)
        
        
    }
}



extension SignInViewController {
    
   
    
    private func navigateToDetailViewController() {
        let homeVC = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
         homeVC.modalPresentationStyle = .fullScreen
         self.present(homeVC, animated: true)
    }
    
    private func showAuthenticationFailedAlert() {
        let alert = UIAlertController(title: "Authentication Failed", message: "Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
