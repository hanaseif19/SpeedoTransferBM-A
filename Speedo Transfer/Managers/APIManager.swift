import Foundation
import Alamofire

class APIManager {
    
    static func PostLoginData(loginRequest: LoginRequest) {
        let param: [String: Any] = [
            "email": loginRequest.email,
            "password": loginRequest.password
        ]
        
        AF.request("https://banquemisr-transfer-service.onrender.com/api/auth/login",
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default)
        .response { response in
            
            if let error = response.error {
                print("Request error: \(error.localizedDescription)")
                return
            }
            
            guard let data = response.data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(LoginResponse.self, from: data)
                print(decodedResponse.message ?? "N/A")
                
                if decodedResponse.message == "Login Successful" {
                    Session.shared.authToken = decodedResponse.token ?? "ABC"
                    fetchUserDataByEmail(email: loginRequest.email)
                    
                    // switchToHomeScreen() // Uncomment if needed
                } else {
                    print("Login failed: \(decodedResponse.message ?? "Failed Login")")
                }
                
            } catch let error {
                print("Decoding error: \(error.localizedDescription)")
                print("HI")
            }
        }
    }
    
    private static func fetchUserDataByEmail(email: String) {
        guard let token = Session.shared.authToken else {
            print("No auth token available")
            return
        }
        
        let urlString = "https://banquemisr-transfer-service.onrender.com/api/customer/email/\(email)"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(urlString,
                   method: .get,
                   headers: headers)
        .response { response in
            
            if let error = response.error {
                print("Request error: \(error.localizedDescription)")
                return
            }
            
            guard let data = response.data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let userResponse = try decoder.decode(CurrentUserResponse.self, from: data)
                CurrentUser.shared.update(from: userResponse)
                switchToHomeScreen()
                print("User data after logging in: \(userResponse.email)")
                
            } catch let error {
                print("Decoding error: \(error.localizedDescription)")
                print("Hello")
            }
        }
    }
    
    static func PostRegistrationData(user: UserRegistrationRequest) {
        let param: [String: Any] = [
            "name": user.name,
            "email": user.email,
            "password": user.password,
            "confirmPassword": user.confirmPassword,
            "country": user.country,
            "birthDate": user.birthDate
        ]
        
        AF.request("https://banquemisr-transfer-service.onrender.com/api/auth/register",
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default)
        .response { response in
            
            if let error = response.error {
                print("Request error: \(error.localizedDescription)")
                return
            }
            
            guard let data = response.data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(PostRegisterBaseResponse.self, from: data)
                print(decodedResponse.httpStatus ?? "N/A")
                
                if decodedResponse.httpStatus == "CREATED" {
                    switchToSignInScreen()
                } else {
                    print("Registration failed: \(decodedResponse.httpStatus ?? "Unknown status")")
                }
                
            } catch let error {
                print("Decoding error: \(error.localizedDescription)")
            }
        }
    }
    
    private static func switchToSignInScreen() {
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.switchToLogin()
            }
        }
    }
    
    private static func switchToHomeScreen() {
        DispatchQueue.main.async {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.switchToProfile()
            }
        }
    }
}
