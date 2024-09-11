//
//  PersonalInfoVC.swift
//  Speedo Transfer
//

import UIKit

class PersonalInfoVC: UIViewController {

    @IBOutlet weak var NameLabel: UILabel!
   
    @IBOutlet weak var DOBLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var CountryLabel: UILabel!
    @IBOutlet weak var BankAccountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.style = .editor
        title = "Profile Information"
        NameLabel.text = CurrentUser.shared.name
        EmailLabel.text=CurrentUser.shared.email
        CountryLabel.text = "United States"
        DOBLabel.text = CurrentUser.shared.birthDate
        BankAccountLabel.text=CurrentUser.shared.accounts[0].accountNumber
        let pullToRefreshGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePullToRefresh))
               view.addGestureRecognizer(pullToRefreshGesture)
    }
    @objc func handlePullToRefresh(_ gesture: UIPanGestureRecognizer) {
           if gesture.state == .ended {
               updateView()
           }
       }

       func updateView() {
           NameLabel.text = CurrentUser.shared.name
           EmailLabel.text=CurrentUser.shared.email
           CountryLabel.text = "United States"
           DOBLabel.text = CurrentUser.shared.birthDate
           BankAccountLabel.text=CurrentUser.shared.accounts[0].accountNumber
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
