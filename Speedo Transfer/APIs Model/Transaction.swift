//
//  Transaction.swift
//  MoneyTransferApp
//
// 
//

import Foundation

struct Transaction: Codable {
    var recipientName: String
    var MasterCardId: String
    var amount: String
    var date: String
}
