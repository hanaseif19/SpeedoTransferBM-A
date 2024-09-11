//
//  ProfileVC.swift
//  Speedo Transfer
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var InitialsLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.style = .editor
        title = "Profile"
        NameLabel.text=CurrentUser.shared.name
        let name = CurrentUser.shared.name ?? "N A"

        let initials = name.split(separator: " ")
            .compactMap { $0.first }
            .map { String($0) }
            .joined()

        InitialsLabel.text = initials.uppercased()
        let pullToRefreshGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePullToRefresh))
               view.addGestureRecognizer(pullToRefreshGesture)
    }
    @objc func handlePullToRefresh(_ gesture: UIPanGestureRecognizer) {
           if gesture.state == .ended {
               updateView()
           }
       }

       func updateView() {
           NameLabel.text=CurrentUser.shared.name
           let name = CurrentUser.shared.name ?? "N A"

           let initials = name.split(separator: " ")
               .compactMap { $0.first }
               .map { String($0) }
               .joined()

           InitialsLabel.text = initials.uppercased()
       }
    
    @IBAction func personalinfoBtnTapped(_ sender: Any) {
        let personalInfo = self.storyboard?.instantiateViewController(withIdentifier: "PersonalInfoVC") as! PersonalInfoVC
        self.navigationController?.pushViewController(personalInfo, animated: true)
    }
    
    @IBAction func settingBtnTapped(_ sender: Any) {
        let setting = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        self.navigationController?.pushViewController(setting, animated: true)
    }
    
    @IBAction func paymentHistoryBtnTapped(_ sender: Any) {
        let transaction = self.storyboard?.instantiateViewController(withIdentifier: "lastTransactionsVC") as! lastTransactionsVC
            self.navigationController?.pushViewController(transaction, animated: true)
          
    }
    
    @IBAction func favListBtnTapped(_ sender: Any) {
        let favList = self.storyboard?.instantiateViewController(withIdentifier: "FavouritesVCViewController") as! FavouritesVCViewController
        self.navigationController?.pushViewController(favList, animated: true)
    }
}
