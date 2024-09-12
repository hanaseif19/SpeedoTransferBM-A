//
//  TransactionDetailsVC.swift
//  Speedo Transfer
//
//  Created by Hana Seif on 09/09/2024.
//

import UIKit

class TransactionDetailsVC: UIViewController {
    var t: TransactionDetails?
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount2: UILabel!
    @IBOutlet weak var Racc: UILabel!
    @IBOutlet weak var Rname: UILabel!
    @IBOutlet weak var Sacc: UILabel!
    @IBOutlet weak var SName: UILabel!
    @IBOutlet weak var amount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.style = .editor
        title = "Successful Transaction" 
        date.text=t?.date
        SName.text=t?.sName
        Sacc.text=t?.sAcc
        Racc.text=t?.Racc
        Rname.text=t?.RName
        amount.text=t?.amount
        amount2.text=amount.text
        
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
