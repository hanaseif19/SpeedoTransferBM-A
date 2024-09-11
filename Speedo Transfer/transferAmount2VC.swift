//
//  transferAmount2VC.swift
//  Speedo Transfer
//
//

import UIKit

class transferAmount2VC: UIViewController {

   
    @IBOutlet weak var amountpt2: UILabel!
    @IBOutlet weak var amountLabel: UILabel!

    @IBOutlet weak var receiverAcc: UILabel!
    @IBOutlet weak var receiverName: UILabel!
    @IBOutlet weak var senderAcc: UILabel!
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var viewFrom: UIView!
    @IBOutlet weak var viewTo: UIView!
    var user : TemptransferUser?
    override func viewDidLoad() {
        super.viewDidLoad()

        viewFrom.layer.cornerRadius = 8
        viewTo.layer.cornerRadius = 8
        self.navigationItem.style = .editor
        title = "Transfer"
        if let amount = user?.amount as? Int {
            amountLabel.text = "\(amount)"
            amountpt2.text="\(amount)"
        }
        senderName.text = CurrentUser.shared.name
        senderAcc.text=CurrentUser.shared.accounts[0].accountNumber
        receiverName.text = user?.name
        receiverAcc.text = user?.accountNumber
       
    }
    
    @IBAction func continueTransferBtnTapped(_ sender: Any) {
        let thirdTransfer = self.storyboard?.instantiateViewController(withIdentifier: "transferAmount3VC") as! transferAmount3VC
        thirdTransfer.user=user
        let transfer: Transfer = Transfer(amount: Int(amountLabel.text!)  , sendCurrency: "EGY", receiverAccNumber: receiverAcc.text, senderAccNumber: senderAcc.text)
        APIManager.PostTransferData(transfer: transfer)
        
        
           self.navigationController?.pushViewController(thirdTransfer, animated: true)
    }
    
    @IBAction func previousTransferBtnTapped(_ sender: Any) {
        let transfer = self.storyboard?.instantiateViewController(withIdentifier: "transferAmountVC") as! transferAmountVC
           self.navigationController?.pushViewController(transfer, animated: true)
    }
    

}
