//
//  User.swift
//  Speedo Transfer
//

import Foundation

struct UserRegistrationRequest: Codable {
    
    var name: String
    var email: String
    var password: String
    var confirmPassword: String
    var country: String
    var birthDate: String
    
}

    struct PostRegisterBaseResponse: Decodable {
        var timestamp: String?
        var message: String?
        var details :String?
        var httpStatus: String?
        var createdAt: String?
        var updatedAt:String?
      
    }

//    struct statusDetails: Codable {
//var error: Bool?
//        var is5xxServerError: Bool?
//        var is4xxClientError: Bool?
//        var is2xxSuccessful : Bool?
//        var is1xxInformational : Bool?
//        var is3xxRedirection : Bool?
//}

//}

struct updateResponse : Codable {

        var updatedAt: String?
        var massage: String?
        var details : String?
        var httpStatusCode: String?
        var name: String?
        var email: String?
        var phoneNumber: String?
}
struct updateModel: Codable {
var name: String?
    var email: String?
    var phoneNumber: String?
}

struct TransactionDetails {
    var date: String?
    var sName: String?
    var sAcc : String?
    var RName: String?
    var Racc: String?
    var amount: String?
}
