//
//  HomeTransactionTableViewCell.swift
//  Speedo Transfer
//
//  Created by Hana Seif on 12/09/2024.
//

import UIKit

class HomeTransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var Receiver: UILabel!
    @IBOutlet weak var sender: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(senderAcc: String , Racc: String, datee: String , amount: String)
    {
        self.sender.text = "From " + senderAcc
        self.Receiver.text = "To " + Racc
        self.amount.text = " EGP " + amount
        self.date.text=datee
    }
}
