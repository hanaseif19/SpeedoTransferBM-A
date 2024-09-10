//
//  AppDelegate.swift
//  Speedo Transfer


import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true // makes us navigate between text boxes 
 
    
               if let isLoggedIn = UserDefaults.standard.object(forKey: "isLoggedIn") as? Bool {
                        if (isLoggedIn)
                        {
                            switchToProfile()
                        }
                        else
                        {
                            switchToLogin()
                        }
                    }
                    else
                    {
                        switchToReg()
                    }
                   
            
        return true

        }
    func switchToLogin()
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let SignIn = sb.instantiateViewController(withIdentifier: "SignInVC") as! SignInViewController
        
        let navVC = UINavigationController(rootViewController: SignIn)
        window?.rootViewController = navVC
      
     //        self.navigationController?.pushViewController(SignIn, animated: true)
    }
   
    func switchToReg()
    {
      // go to splash screen 
    }
    func switchToProfile()
    {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = sb.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
         homeVC.modalPresentationStyle = .fullScreen
        let navVC = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = navVC
        
       
       
    }
    
    
    
//    func setRootView() {
//        if let isLoggedIn = UserDefaultsManager.shared().isLoggedIn {
//            if isLoggedIn {
//                switchToHomeState()
//            } else {
//                switchToAuthState()
//            }
//        }
//    }
//    
//    func switchToAuthState() {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let logVC = sb.instantiateViewController(withIdentifier: "SignInVC") as! signInVC
//        UserDefaultsManager.shared().isLoggedIn = false
//        window?.rootViewController = logVC
//    }
//    
//    func switchToHomeState() {
//        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let homeVC = sb.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
//        window?.rootViewController = homeVC
//    }
    



}

