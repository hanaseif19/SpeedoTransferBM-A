//
//  transferAmount3VC.swift
//  Speedo Transfer
//
//

import UIKit

class transferAmount3VC: UIViewController {
    @IBOutlet weak var SenderAcc: UILabel!
    @IBOutlet weak var Amount: UILabel!
    @IBOutlet weak var RAccount: UILabel!
    @IBOutlet weak var RName: UILabel!
    @IBOutlet weak var SenderName: UILabel!
    var user : TemptransferUser?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.style = .editor
        title = "Transfer"
        if let amount = user?.amount as? Int {
            Amount.text = "\(amount)"
          
        }
        RAccount.text=user?.accountNumber
        print(user?.name, "in third VC")
        RName.text=user?.name
        SenderAcc.text = CurrentUser.shared.accounts[0].accountNumber
        SenderName.text=CurrentUser.shared.name
        
    }
    
    @IBAction func backHomeBtnTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    
    
    @IBAction func addFavouriteBtnTapped(_ sender: Any) {
        let favorite = FavoriteData(accountNumber: RAccount.text, recipientName:   RName.text)
        print("recipient" , RName.text! , " account Number", RAccount.text! )
        APIManager.addToFavorites(favorite: favorite)
        self.showALert(title: "Success", message:"Added to favorites")
    }
    
    
}
