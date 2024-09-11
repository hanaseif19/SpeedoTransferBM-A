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
     //   self.window = InactivityWindow(frame: UIScreen.main.bounds)

       // self.window = InactivityWindow(frame: UIScreen.main.bounds)

//               if let isLoggedIn = UserDefaults.standard.object(forKey: "isLoggedIn") as? Bool {
//                        if (isLoggedIn)
//                        {
//                            switchToProfile()
//                        }
//                        else
//                        {
//                            switchToLogin()
//                        }
//                    }
//                    else
//                    {
//                        switchToReg()
//                    }
                       self.window?.makeKeyAndVisible()

       // startInactivityTimer()

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
    func applicationDidTimout(notification: NSNotification) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let SignIn = sb.instantiateViewController(withIdentifier: "SignInVC") as! SignInViewController
        let navVC = UINavigationController(rootViewController: SignIn)
        window?.rootViewController = navVC
       }
    func switchToReg()
    {
      // go to splash screen 
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

