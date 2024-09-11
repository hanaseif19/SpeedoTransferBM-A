//
//  transferAmountVC.swift
//  Speedo Transfer
//

import UIKit
import FittedSheets

class transferAmountVC: UIViewController {
    
   
    @IBOutlet weak var amountLabel: CustomTextField!
    @IBOutlet weak var accLabel: CustomTextField!
    @IBOutlet weak var nameLabel: CustomTextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.style = .editor
        title = "Transfer"
        
    }
    
    @IBAction func favoriteBtnTapped(_ sender: Any) {
        guard let countrySheet = storyboard?.instantiateViewController(withIdentifier: "favouritsVC") as? favouritsVC else {
            print("Could not instantiate favouritsVC")
            return
        }
        
        let sheetController = SheetViewController(controller: countrySheet, sizes: [.fixed(500), .percent(0.5), .intrinsic])
        sheetController.cornerRadius=50
        sheetController.gripColor=UIColor(named: "LabelColor")
        self.present(sheetController, animated: true, completion: nil)
    }
    
    
    @IBAction func continueTransferBtnTapped(_ sender: Any) {
        let secondTransfer = self.storyboard?.instantiateViewController(withIdentifier: "transferAmount2VC") as! transferAmount2VC

        guard let amountText = amountLabel.text, let amount = Int(amountText) else {
            print("Invalid amount")
            print("HI big problem")
            return
        }

        guard let name = nameLabel.text, !name.isEmpty, let accountNumber = accLabel.text, !accountNumber.isEmpty else {
            print("Invalid user details")
            return
        }

        let user = TemptransferUser(name: name, accountNumber: accountNumber, amount: amount)
        secondTransfer.user = user
        self.navigationController?.pushViewController(secondTransfer, animated: true)
    }

    
}
