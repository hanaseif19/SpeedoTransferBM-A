//
//  TabBarController.swift
//  Speedo Transfer
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")

        // Do any additional setup after loading the view.
    }

}
