//
//  AppDelegate.swift
//  Speedo Transfer


import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    // var window: InactivityWindow?
    var inactivityTimer: Timer?
    let timeoutInterval: TimeInterval = 120 // 120 seconds
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true // makes us navigate between text boxes
        
        
        
        
        if let PreviousAccess = UserDefaults.standard.object(forKey: "PreviousAccess") as? Bool {
            
            switchToLogin()
            
            self.window?.makeKeyAndVisible()
            
            
            
            
            
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
      
        func switchToProfile() {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = sb.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
            tabBarController.modalPresentationStyle = .fullScreen
            
            if let window = UIApplication.shared.delegate?.window {
                window?.rootViewController = tabBarController
                window?.makeKeyAndVisible()
            }
        }
        
        
        
        
        
        
        
    }

