//
//  Transaction.swift
//  MoneyTransferApp
//
// 
//

import Foundation

//struct Transaction: Codable {
//    var transactionId: Int
//    var fromAccount: String
//    var toAccount: String
//    var amount: Int
//    var status: Bool
//    var timestamp: String
//}
struct Transaction {
    var recipientName: String?
    var MasterCardId: String?
    var amount: String?
    var date: String? 
}
//struct TransactionHistoryResponse : Codable {
//    var transactions: [Transaction]
//}


//{
//"transactions": [
//{
//"transactionId": 0,
//"fromAccount": "string",
//"toAccount": "string",
//"amount": 0,
//"status": true,
//"timestamp": "2024-09-08T19:13:48.937Z"
//}
//]
//}
