//
//  LoginRequest.swift
//  Speedo Transfer

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
}
struct LoginResponse: Codable {
    let message: String?
    let token: String?
    let tokenType: String?
    let status: String?
//    "message": "Login Successful",
//        "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJoYW5hQGdtYWlsLmNvbSIsImlhdCI6MTcyNjAwNjQ2NiwiZXhwIjoxNzI2MDkyODY2fQ.H-WSdXw0E1uCArIXD04tr2OT3ZmOu9uKbf37suWrnlc",
//        "tokenType": "Bearer",
//        "status": "ACCEPTED"
}
//{
//"amount": 0,
//"sendCurrency": "EGY",
//"receiverAccNumber": "string",
//"senderAccNumber": "string"
//}
struct Transfer : Codable  {
    let amount: Int?
    let sendCurrency: String?
    let receiverAccNumber : String?
    let senderAccNumber : String?
    
}
struct TransferBaseResponse: Codable {
   
   let transactionId: Int?
    let fromAccount: String?
    let toAccount: String?
    let amount: Int?
    let status: Bool?
    let timestamp: String?
    }
struct FavoriteData: Codable
{
    let accountNumber: String?
    let recipientName: String?
}
