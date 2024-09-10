//
//  User.swift
//  Speedo Transfer
//

import Foundation

struct UserRegistrationRequest: Codable {
//    var firstName: String
//    var lastName: String
    var name: String
    var email: String
    var password: String
//    var userName: String
//    var country: String
//    var dateOfBirth: String

    enum CodingKeys: String, CodingKey {
//        case firstName
//        case lastName
        case name
        case email
        case password
//        case userName
//        case country
//        case dateOfBirth
    }
}
