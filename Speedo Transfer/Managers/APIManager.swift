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
                    fetchUserDataByEmail(email: loginRequest.email, redirect: true)
                    print("Yesss u logged in")
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
    
    public static func fetchUserDataByEmail(email: String, redirect: Bool) {
       //  var apiClient  = URLSessionApiClient()
        guard let token = Session.shared.authToken else {
            print("No auth token available")
            return
        }
        
        let urlString = "https://banquemisr-transfer-service.onrender.com/api/customer/email/\(email)"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
//        let url = URL(string: urlString)!
//        let apiRequest = APIRequest(url: url, method: .GET, headers: headers , queryParams: nil , body: nil )
        
//        apiClient.dataTask(apiRequest) { (_ result: Result<CurrentUserResponse, Error>) in
//            switch result {
//                       case .failure(let error):
//                           print(error)
//                       case .success(let data):
//                           print("Data: \(data)")
//                       }
//        }
//        
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
                if (redirect)
                {
                    switchToHomeScreen()
                }
                print("User data after logging in: \(userResponse.email)")
                print( userResponse.accounts![0].accountNumber )
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
    static func updateData (updateRequest: updateModel)
     {
         guard let token = Session.shared.authToken else {
             print("No auth token available")
             return
         }
         

         let headers: HTTPHeaders = [
             "Authorization": "Bearer \(token)"
         ]
         
//         "name":"sama Ahmed" ,
//       "email": "sama@gmail.com",
//       "phoneNumber": "01101506430"
        let param: [String: Any] = [
            "name": updateRequest.name!,
            "email": updateRequest.email!,
            "phoneNumber": updateRequest.phoneNumber!
        ]
         print("name",updateRequest.name!)
         print(  "email", updateRequest.email!)
         print("phoneNumber", updateRequest.phoneNumber!)
        print("https://banquemisr-transfer-service.onrender.com/api/customer/update?email=\(CurrentUser.shared.email!)")
         AF.request("https://banquemisr-transfer-service.onrender.com/api/customer/update?email=\(CurrentUser.shared.email!)",
                   method: .put,
                   parameters: param,
                   encoding: JSONEncoding.default,
     headers:headers)
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
            
                let decodedResponse = try decoder.decode(updateResponse.self, from: data)
                print(decodedResponse.email ?? "hi")
                print("name", decodedResponse.name!)
                print("email", decodedResponse.email!)
                
                CurrentUser.shared.name=decodedResponse.name
                CurrentUser.shared.email=decodedResponse.email
           
                
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
    
  
   
    static func PostTransferData(transfer: Transfer) {
        let param: [String: Any] = [
            "amount": transfer.amount,
            "sendCurrency": "EGY",
            "receiverAccNumber": transfer.receiverAccNumber ,
            "senderAccNumber" : CurrentUser.shared.accounts[0].accountNumber
        ]
        let token = Session.shared.authToken
        let headers: HTTPHeaders = [
                  "Authorization": "Bearer \(token ??  "ABC")"
              ]
        AF.request("https://banquemisr-transfer-service.onrender.com/api/transfer/account",
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default, headers: headers )
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
                let decodedResponse = try decoder.decode(TransferBaseResponse.self, from: data)
                print(" I transferred " , decodedResponse.amount)
                APIManager.fetchUserDataByEmail(email: CurrentUser.shared.email!, redirect: false)
                
            } catch let error {
                print("Decoding error: \(error.localizedDescription)")
                print("HI")
            }
        }
    }
    static func addToFavorites( favorite: FavoriteData)
    {
        let param: [String: Any] = [
            "accountNumber": favorite.accountNumber!,
            "recipientName": favorite.recipientName!,
          
        ]
        let token = Session.shared.authToken
        let headers: HTTPHeaders = [
                  "Authorization": "Bearer \(token ??  "ABC")"
              ]
        AF.request("https://banquemisr-transfer-service.onrender.com/api/favourites",
                   method: .post,
                   parameters: param,
                   encoding: JSONEncoding.default, headers: headers )
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
                let decodedResponse = try decoder.decode(FavoriteData.self, from: data)
//                print(" I transferred " , decodedResponse.amount)
//                APIManager.fetchUserDataByEmail(email: CurrentUser.shared.email!, redirect: false)
                print("i added", decodedResponse.recipientName!)
                
            } catch let error {
                print("Decoding error: \(error.localizedDescription)")
                print("HI")
            }
        }
    }
}
