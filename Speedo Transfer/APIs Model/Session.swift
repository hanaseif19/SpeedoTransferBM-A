import Foundation

class Session {
    static let shared = Session()
    private init() {}
    
    var authToken: String? 
}
