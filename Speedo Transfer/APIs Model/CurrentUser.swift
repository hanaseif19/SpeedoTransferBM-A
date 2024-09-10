// CurrentUser.swift

import Foundation

class CurrentUser {
    static let shared = CurrentUser()
    
    private init() {}
    
    var id: Int? = nil
    var name: String? = nil
    var email: String? = nil
    var phoneNumber: String? = nil
    var gender: String? = nil
    var birthDate: String? = nil
    var username: String? = nil
    var createdAt: String? = nil
    var updatedAt: String? = nil
    var accounts: [Account] = []
    
    func update(from response: CurrentUserResponse) {
        self.id = response.id
        self.name = response.name
        self.email = response.email
        self.phoneNumber = response.phoneNumber
        self.gender = response.gender
        self.birthDate = response.birthDate
        self.username = response.username
        self.createdAt = response.createdAt
        self.updatedAt = response.updatedAt
        self.accounts = response.accounts ?? []
    }
}

struct Account: Codable {
    let id: Int?
    let accountNumber: String?
    let accountType: String?
    let balance: Int?
    let currency: String?
    let accountName: String?
    let accountDescription: String?
    let active: Bool?
    let createdAt: String?
    let updatedAt: String?
}

struct CurrentUserResponse: Codable {
    let id: Int?
    let name: String?
    let email: String?
    let phoneNumber: String?
    let gender: String?
    let birthDate: String?
    let username: String?
    let createdAt: String?
    let updatedAt: String?
    let accounts: [Account]?
}
