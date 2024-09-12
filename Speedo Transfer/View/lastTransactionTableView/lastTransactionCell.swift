//
//  lastTranactionCell.swift
//  Speedo Transfer
//
//

import UIKit

class lastTransactionCell: UITableViewCell {

   
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var RLabel: UILabel!
    @IBOutlet weak var Name: UILabel!
    
    // @IBOutlet weak var Money: UILabel!
//    @IBOutlet weak var ReceiverAcc: UILabel!
//    @IBOutlet weak var date: UILabel!
//    @IBOutlet weak var SenderAcc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(SenderAccount: String, date: String,  receiverAccount: String, amount: String) {
        
        self.nameLabel.text="From " + SenderAccount
        self.RLabel.text="To " + receiverAccount
       self.moneyLabel.text="EGP " + amount
        self.dateLabel.text=date
        
    }
}
