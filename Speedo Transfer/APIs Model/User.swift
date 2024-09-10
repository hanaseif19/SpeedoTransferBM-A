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

//    struct statusDetails: Decodable {
//        var is5xxServerError: String?
//        var is4xxClientError: String?
//        var is2xxSuccessful : String?
//        var is1xxInformational : String?
//        var is3xxRedirection : String?
//        
//        
//        
//    
//}
